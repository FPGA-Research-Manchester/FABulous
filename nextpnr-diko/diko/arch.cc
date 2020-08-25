/*
 *  nextpnr -- Next Generation Place and Route
 *
 *  Copyright (C) 2018  Clifford Wolf <clifford@symbioticeda.com>
 *  Copyright (C) 2018  Serge Bazanski <q3k@symbioticeda.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

#include <algorithm>
#include <cmath>
#include <regex>
#include <fstream>
#include "cells.h"
#include "gfx.h"
#include "log.h"
#include "nextpnr.h"
#include "placer1.h"
#include "router1.h"
#include "util.h"
#include <iostream>


NEXTPNR_NAMESPACE_BEGIN

std::unique_ptr<const ChipInfo> chip_info;
ChipInfo::ChipInfo(BaseCtx *ctx) : num_bels(0), num_wires(0), num_pips(0)
{
    TileId num_tiles = 0;
    std::unordered_map<IdString, TileId> tile_name_to_idx;

    std::ifstream fbels("bel.txt");
    std::/*unordered_*/map<std::pair<TileId,IdString>, WireId> tile_wire_name_to_idx;
    std::string line, tile, x, y, name, i;
    WireId pin;
    while (std::getline(fbels >> std::ws, line)) {
        if (line.empty() || line.front() == '#') continue;
        std::stringstream ss(line);
        std::getline(ss, tile, ',');
        auto tilename = tile;
        auto r = tile_name_to_idx.emplace(ctx->id(tile), num_tiles);
        auto tile = r.first->second;
        bel_to_tile.emplace_back(tile);
        std::getline(ss, x, ',');
        std::getline(ss, y, ',');
        Loc loc;
        loc.x = boost::lexical_cast<int>(x.c_str()+1);
        loc.y = boost::lexical_cast<int>(y.c_str()+1);
        if (r.second) {
            tile_to_xy.emplace_back(loc.x,loc.y);
            ++num_tiles;
        }
        std::getline(ss, name, ',');
        bel_to_name.emplace_back(ctx->id(name)); 
        bel_by_name.insert(std::make_pair(ctx->id(tilename + std::string(".") + name), bel_to_name.size() - 1));
        std::getline(ss, i, ',');
        //std::ofstream myfile;
        //myfile.open ("example.txt", std::ios_base::app);
        //myfile << tilename + std::string(".") + name;
        //myfile << ", " + i;
        //myfile << "\n";
        //myfile.close();
        auto type = ctx->id(i);
        bel_to_type.push_back(type);
        if (type == id_LUT4 || type == id_IOBUF || type == ctx->id("InPass4_frame_config") || type == ctx->id("OutPass4_frame_config"))
            loc.z = (0) + name.back() - 'A';
        else
            loc.z = 0;
        bel_to_loc.emplace_back(loc);
        boost::container::flat_map<IdString,WireId> pin_wires;
        while (std::getline(ss, i, ',')) {
            pin.index = num_wires;
            if (tile_wire_name_to_idx.emplace(std::make_pair(tile,ctx->id(i)), pin).second)
                num_wires++;
            pin_wires.emplace(ctx->id(i), pin);
        }
        bel_to_pin_wire.emplace_back(std::move(pin_wires));
    }
    fbels.close();
    num_bels = bel_to_name.size();
    assert(bel_to_tile.size() == num_bels);
    assert(bel_to_type.size() == num_bels);
    assert(bel_to_loc.size() == num_bels);
    assert(bel_to_pin_wire.size() == num_bels);
    NPNR_ASSERT(num_wires == tile_wire_name_to_idx.size());

    std::ifstream fpips("pips.txt");
    WireId wire;
    PipId pip;
    DelayInfo delay;
    while (std::getline(fpips, line)) {
        if (line.front() == '#') continue;
        std::stringstream ss(line);
        std::getline(ss, i, ',');
        auto r1 = tile_name_to_idx.find(ctx->id(i));
        if (r1 == tile_name_to_idx.end())
            continue;
        auto src_tile = r1->second;
        std::string src, dst;
        std::getline(ss, src, ',');
        std::getline(ss, i, ',');
        r1 = tile_name_to_idx.find(ctx->id(i));
        if (r1 == tile_name_to_idx.end())
            continue;
        auto dst_tile = r1->second;
        std::getline(ss, dst, ',');
        wire.index = num_wires;
        auto r2 = tile_wire_name_to_idx.emplace(std::make_pair(src_tile,ctx->id(src)), wire);
        if (r2.second)
            ++num_wires;
        auto src_wire = r2.first->second;
        wire.index = num_wires;
        r2 = tile_wire_name_to_idx.emplace(std::make_pair(dst_tile,ctx->id(dst)), wire);
        if (r2.second)
            ++num_wires;
        auto dst_wire = r2.first->second;
        pip_to_src_dst.emplace_back(src_wire, dst_wire);
        wire_to_pips_downhill.resize(num_wires);
        pip.index = num_pips++;
        wire_to_pips_downhill[src_wire.index].emplace_back(pip);
        std::getline(ss, i, ',');
        delay.delay = boost::lexical_cast<int>(i);
        pip_to_delay.emplace_back(delay);
        std::getline(ss, i, ',');
        pip_to_txt.emplace_back(i);
    }
    fpips.close();
    assert(num_pips == pip_to_src_dst.size());
    assert(num_pips == pip_to_delay.size());
    assert(num_pips == pip_to_txt.size());

    NPNR_ASSERT(num_tiles == tile_name_to_idx.size());
    NPNR_ASSERT(num_tiles == tile_to_xy.size());
    tile_to_name.resize(num_tiles);
    for (auto i: tile_name_to_idx) {
        tile_to_name[i.second] = i.first;
    }
    NPNR_ASSERT(num_wires == tile_wire_name_to_idx.size());
    wire_to_name.resize(num_wires);
    wire_to_tile.resize(num_wires);
    for (auto i: tile_wire_name_to_idx) {
        wire_to_tile[i.second.index] = i.first.first;
        wire_to_name[i.second.index] = i.first.second;
    }
}

// -----------------------------------------------------------------------

void IdString::initialize_arch(const BaseCtx *ctx)
{
#define X(t) initialize_add(ctx, #t, ID_##t);
#include "constids.inc"
#undef X
}

// -----------------------------------------------------------------------

Arch::Arch(ArchArgs args) : args(args)
{
    chip_info = std::unique_ptr<ChipInfo>(new ChipInfo(this));

    /*if (getCtx()->verbose)*/ {
        log_info("Number of bels:  %d\n", chip_info->num_bels);
        log_info("Number of wires: %d\n", chip_info->num_wires);
        log_info("Number of pips:  %d\n", chip_info->num_pips);
        log_flush();
    }

    bel_to_cell.resize(chip_info->num_bels);
    wire_to_net.resize(chip_info->num_wires);
    pip_to_net.resize(chip_info->num_pips);
}

// -----------------------------------------------------------------------

std::string Arch::getChipName() const
{
    return {};
}

// -----------------------------------------------------------------------

IdString Arch::archArgsToId(ArchArgs args) const
{
    return IdString();
}

// -----------------------------------------------------------------------

static bool endsWith(const std::string& str, const std::string& suffix)
{
    return str.size() >= suffix.size() && 0 == str.compare(str.size()-suffix.size(), suffix.size(), suffix);
}

BelId Arch::getBelByName(IdString name) const
{
    //std::string n = name.str(this);
    //int ndx = 0;
    //if (endsWith(n,"_A") || endsWith(n,"_B") || endsWith(n,"_C") || endsWith(n,"_D"))
    //{
    //    ndx = (int)(n.back() - 'A');
    //    n = n.substr(0,n.size()-2);
    //}
    //auto it = chip_info->sites.findSiteIndex(n);
    //if (it != SiteIndex(-1)) {
    //    BelId id = chip_info->site_index_to_bel.at(it);
    //    id.index += ndx;
    //    return id; 
    //}
    //return BelId();

    BelId ret;

    //if (bel_by_name.empty()) {
    //    for (int i = 0; i < chip_info->num_bels; i++)
    //        bel_by_name[id(chip_info->bel_data[i].name.get())] = i;
    //}

    auto it = chip_info->bel_by_name.find(name);
    if (it != chip_info->bel_by_name.end())
        ret.index = it->second;
    else 
        log_error("Not Found");

    return ret;
}

BelId Arch::getBelByLocation(Loc loc) const
{
    BelId bel;

    if (bel_by_loc.empty()) {
        //for (int i = 0; i < chip_info->num_bels; i++) {
        //    BelId b;
        //    b.index = i;
        //    bel_by_loc[getBelLocation(b)] = b;
        //}
    }

    auto it = bel_by_loc.find(loc);
    if (it != bel_by_loc.end())
        bel = it->second;

    return bel;
}

BelRange Arch::getBelsByTile(int x, int y) const
{
    BelRange br;
    NPNR_ASSERT("TODO");
    return br;
}

PortType Arch::getBelPinType(BelId bel, IdString pin) const
{
    NPNR_ASSERT(bel != BelId());
    NPNR_ASSERT("TODO");
    return PORT_INOUT;
}

std::vector<std::pair<IdString, std::string>> Arch::getBelAttrs(BelId bel) const
{
    std::vector<std::pair<IdString, std::string>> ret;
    return ret;
}

WireId Arch::getBelPinWire(BelId bel, IdString pin) const
{
    auto pin_name = pin.str(this);
    auto bel_type = getBelType(bel);
    if (bel_type == id_SLICE_LUT6) {
    	//std::cout << pin_name;
        // For all LUT based inputs and outputs (I1-I6,O,OQ,OMUX) then change the I/O into the LUT
        if (pin_name[0] == 'I' || pin_name[0] == 'O') {
            //switch (chip_info->bel_to_loc[bel.index].z) {
            //case 0:
            //case 4:
            //    pin_name[0] = 'A';
            //    break;
            //case 1:
            //case 5:
            //    pin_name[0] = 'B';
            //    break;
            //case 2:
            //case 6:
            //    pin_name[0] = 'C';
            //    break;
            //case 3:
            //case 7:
            //    pin_name[0] = 'D';
            //    break;
            //default:
            //    throw;
            //}
        }
    } /*else if (bel_type == id_PS7 || bel_type == id_MMCME2_ADV) {
        // e.g. Convert DDRARB[0] -> DDRARB0
        pin_name.erase(std::remove_if(pin_name.begin(), pin_name.end(), boost::is_any_of("[]")), pin_name.end());
    }*/

    //auto site_index = chip_info->bel_to_site_index[bel.index];
    //const auto &site = chip_info->sites.getSite(site_index);
    //auto &tw = site.getPinTilewire(pin_name);

    //if (twgetPin.isUndefined())
    //    log_error("no wire found for site '%s' pin '%s' \n", chip_info->bel_to_name(bel.index).c_str(),
    //              pin_name.c_str());

    //return chip_info->tilewire_to_wire(tw);
    
    // if (bel_type == id_SLICE_LUT6) {
    //     auto z = chip_info->bel_to_loc[bel.index].z;
    //     if (z < 8) {
    //         if (pin == id_I1) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1,'A'+z) + "1"));
    //         if (pin == id_I2) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1,'A'+z) + "2"));
    //         if (pin == id_I3) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1,'A'+z) + "3"));
    //         if (pin == id_I4) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1,'A'+z) + "4"));
    //         if (pin == id_I5) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1,'A'+z) + "5"));
    //         if (pin == id_I6) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1,'A'+z) + "6"));
    //         if (pin == id_O) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1, 'A'+z) + "_O"));
    //         if (pin == id_OQ) return chip_info->bel_to_pin_wire[bel.index].at(id("M_SITE_0_" + std::string(1, 'A'+z) + "Q"));
    //         throw;
    //     }
    //     else {
    //         z -= 8;
    //         assert(z < 8);
    //         if (pin == id_I1) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1,'A'+z) + "1"));
    //         if (pin == id_I2) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1,'A'+z) + "2"));
    //         if (pin == id_I3) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1,'A'+z) + "3"));
    //         if (pin == id_I4) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1,'A'+z) + "4"));
    //         if (pin == id_I5) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1,'A'+z) + "5"));
    //         if (pin == id_I6) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1,'A'+z) + "6"));
    //         if (pin == id_O) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1, 'A'+z) + "_O"));
    //         if (pin == id_OQ) return chip_info->bel_to_pin_wire[bel.index].at(id("L_SITE_0_" + std::string(1, 'A'+z) + "Q"));
    //     }
    // }

    if (bel_type == id_LUT4){
    	auto z = chip_info->bel_to_loc[bel.index].z;
    	if (pin == id_I0) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_I0"));
        //log_info("I0");
    	if (pin == id_I1) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_I1"));
        //log_info("I1");    	
        if (pin == id_I2) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_I2"));
        //log_info("I2");   	
        if (pin == id_I3) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_I3"));
    	//log_info("I3");  
        if (pin == id_CI) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_Ci")); 
    	//log_info("Ci");  
        if (pin == id_CO) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_Co")); 
    	//log_info("About to go into O");  
        //log_info(("L" + std::string(1,'A'+z) + "_O").c_str());
        if (pin == id_O) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_O")); 
    	//log_info("Leaving O");
        //if (pin == id_OQ) return chip_info->bel_to_pin_wire[bel.index].at(id("L" + std::string(1,'A'+z) + "_O"));

    } else if (bel_type == id_IOBUF){
        auto z = chip_info->bel_to_loc[bel.index].z;
        if (pin == id_I) return chip_info->bel_to_pin_wire[bel.index].at(id(std::string(1,'A'+z) + "_O"));
        if (pin == id_O) return chip_info->bel_to_pin_wire[bel.index].at(id(std::string(1,'A'+z) + "_I"));
    } else if (bel_type == this->id("IBUF") || bel_type == this->id("InPass4_frame_config")){
    	auto z = chip_info->bel_to_loc[bel.index].z;
        if (pin == this->id("O[0]")) return chip_info->bel_to_pin_wire[bel.index].at(id("OP" + std::string(1,'A'+z) + "_O0"));
        if (pin == this->id("O[1]")) return chip_info->bel_to_pin_wire[bel.index].at(id("OP" + std::string(1,'A'+z) + "_O1"));
        if (pin == this->id("O[2]")) return chip_info->bel_to_pin_wire[bel.index].at(id("OP" + std::string(1,'A'+z) + "_O2"));
        if (pin == this->id("O[3]")) return chip_info->bel_to_pin_wire[bel.index].at(id("OP" + std::string(1,'A'+z) + "_O3"));
    } else if (bel_type == this->id("OBUF") || bel_type == this->id("OutPass4_frame_config")){
    	auto z = chip_info->bel_to_loc[bel.index].z;
        if (pin == this->id("I[0]")) return chip_info->bel_to_pin_wire[bel.index].at(id("RES" + std::string(1,'1'+z) + "_I0"));
        if (pin == this->id("I[1]")) return chip_info->bel_to_pin_wire[bel.index].at(id("RES" + std::string(1,'1'+z) + "_I1"));
        if (pin == this->id("I[2]")) return chip_info->bel_to_pin_wire[bel.index].at(id("RES" + std::string(1,'1'+z) + "_I2"));
        if (pin == this->id("I[3]")) return chip_info->bel_to_pin_wire[bel.index].at(id("RES" + std::string(1,'1'+z) + "_I3"));
    }

    return WireId{};
    
}

std::vector<IdString> Arch::getBelPins(BelId bel) const
{
    std::vector<IdString> ret;
    NPNR_ASSERT("TODO");
    return ret;
}

// -----------------------------------------------------------------------

WireId Arch::getWireByName(IdString name) const
{
    WireId ret;
    //if (wire_by_name.empty()) {
    //    for (int i = 0; i < chip_info->num_wires; i++)
    //        wire_by_name[id(chip_info->wire_to_name(i))] = i;
    //}

    //auto it = wire_by_name.find(name);
    //if (it != wire_by_name.end())
    //    ret.index = it->second;

    return ret;
}

IdString Arch::getWireType(WireId wire) const
{
    NPNR_ASSERT(wire != WireId());
    NPNR_ASSERT("TODO");
    return IdString();
}

// -----------------------------------------------------------------------
std::vector<std::pair<IdString, std::string>> Arch::getWireAttrs(WireId wire) const
{
    std::vector<std::pair<IdString, std::string>> ret;
    NPNR_ASSERT("TODO");
    return ret;
}

// -----------------------------------------------------------------------

PipId Arch::getPipByName(IdString name) const
{
    PipId ret;

    //if (pip_by_name.empty()) {
    //    for (int i = 0; i < chip_info->num_pips; i++) {
    //        PipId pip;
    //        pip.index = i;
    //        pip_by_name[getPipName(pip)] = i;
    //    }
    //}

    //auto it = pip_by_name.find(name);
    //if (it != pip_by_name.end())
    //    ret.index = it->second;

    return ret;
}

IdString Arch::getPipName(PipId pip) const
{
    NPNR_ASSERT(pip != PipId());

    auto src_wire = getPipSrcWire(pip);

    std::stringstream pip_name;
    pip_name << chip_info->tile_to_name[chip_info->wire_to_tile[getPipDstWire(pip).index]].str(this);
    pip_name << getWireName(src_wire).str(this) << ".->." << getWireName(getPipDstWire(pip)).str(this);
    return id(pip_name.str());
}

std::vector<std::pair<IdString, std::string>> Arch::getPipAttrs(PipId pip) const
{
    std::vector<std::pair<IdString, std::string>> ret;
    NPNR_ASSERT("TODO");
    return ret;
}

// -----------------------------------------------------------------------

BelId Arch::getPackagePinBel(const std::string &pin) const { return getBelByName(id(pin)); }

std::string Arch::getBelPackagePin(BelId bel) const
{
    NPNR_ASSERT("TODO");
    return "";
}

// -----------------------------------------------------------------------

GroupId Arch::getGroupByName(IdString name) const
{
    for (auto g : getGroups())
        if (getGroupName(g) == name)
            return g;
    return GroupId();
}

IdString Arch::getGroupName(GroupId group) const
{
    std::string suffix;

    switch (group.type) {
    NPNR_ASSERT("TODO");
    default:
        return IdString();
    }

    return id("X" + std::to_string(group.x) + "/Y" + std::to_string(group.y) + "/" + suffix);
}

std::vector<GroupId> Arch::getGroups() const
{
    std::vector<GroupId> ret;
    NPNR_ASSERT("TODO");
    return ret;
}

std::vector<BelId> Arch::getGroupBels(GroupId group) const
{
    std::vector<BelId> ret;
    return ret;
}

std::vector<WireId> Arch::getGroupWires(GroupId group) const
{
    std::vector<WireId> ret;
    return ret;
}

std::vector<PipId> Arch::getGroupPips(GroupId group) const
{
    std::vector<PipId> ret;
    NPNR_ASSERT("TODO");
    return ret;
}

std::vector<GroupId> Arch::getGroupGroups(GroupId group) const
{
    std::vector<GroupId> ret;
    NPNR_ASSERT("TODO");
    return ret;
}

// -----------------------------------------------------------------------

bool Arch::getBudgetOverride(const NetInfo *net_info, const PortRef &sink, delay_t &budget) const { return false; }

// -----------------------------------------------------------------------

bool Arch::place() { return placer1(getCtx(), Placer1Cfg(getCtx())); }

bool Arch::route() { return router1(getCtx(), Router1Cfg(getCtx())); }

// -----------------------------------------------------------------------

DecalXY Arch::getBelDecal(BelId bel) const
{
    DecalXY decalxy;
    decalxy.decal.type = DecalId::TYPE_BEL;
    decalxy.decal.index = bel.index;
    decalxy.decal.active = bel_to_cell.at(bel.index) != nullptr;
    return decalxy;
}

DecalXY Arch::getWireDecal(WireId wire) const
{
    DecalXY decalxy;
    decalxy.decal.type = DecalId::TYPE_WIRE;
    decalxy.decal.index = wire.index;
    decalxy.decal.active = wire_to_net.at(wire.index) != nullptr;
    return decalxy;
}

DecalXY Arch::getPipDecal(PipId pip) const
{
    DecalXY decalxy;
    decalxy.decal.type = DecalId::TYPE_PIP;
    decalxy.decal.index = pip.index;
    decalxy.decal.active = pip_to_net.at(pip.index) != nullptr;
    return decalxy;
};

DecalXY Arch::getGroupDecal(GroupId group) const
{
    DecalXY decalxy;
    decalxy.decal.type = DecalId::TYPE_GROUP;
    decalxy.decal.index = (group.type << 16) | (group.x << 8) | (group.y);
    decalxy.decal.active = true;
    return decalxy;
};

std::vector<GraphicElement> Arch::getDecalGraphics(DecalId decal) const
{
    std::vector<GraphicElement> ret;

    //if (decal.type == DecalId::TYPE_BEL) {
    //    BelId bel;
    //    bel.index = decal.index;
    //    auto bel_type = getBelType(bel);
    //    int x = chip_info->bel_to_loc[bel.index].x;
    //    int y = chip_info->bel_to_loc[bel.index].y;
    //    int z = chip_info->bel_to_loc[bel.index].z;
    //    if (bel_type == id_SLICE_LUT6) {
    //        GraphicElement el;
    //        /*if (z>3) {
    //            z = z - 4;
    //            x -= logic_cell_x2- logic_cell_x1;
    //        }*/
    //        el.type = GraphicElement::TYPE_BOX;
    //        el.style = decal.active ? GraphicElement::STYLE_ACTIVE : GraphicElement::STYLE_INACTIVE;
    //        el.x1 = x + logic_cell_x1;
    //        el.x2 = x + logic_cell_x2;
    //        el.y1 = y + logic_cell_y1 + (z)*logic_cell_pitch;
    //        el.y2 = y + logic_cell_y2 + (z)*logic_cell_pitch;
    //        ret.push_back(el);
    //    }

    //}

    return ret;
}

// -----------------------------------------------------------------------

bool Arch::getCellDelay(const CellInfo *cell, IdString fromPort, IdString toPort, DelayInfo &delay) const
{
    if (cell->type == id_LUT4) {
        if (fromPort.index >= id_I0.index && fromPort.index <= id_I3.index) {
            if (toPort == id_O) {
                delay.delay = 124; // Tilo
                return true;
            }
            if (toPort == id_OQ) {
                delay.delay = 95; // Tas
                return true;
            }
        }
        if (fromPort == id_CLK) {
            if (toPort == id_OQ) {
                delay.delay = 456; // Tcko
                return true;
            }
        }
    } else if (cell->type == id_BUFGCTRL) {
        return true;
    }
    return false;
}

// Get the port class, also setting clockPort to associated clock if applicable
TimingPortClass Arch::getPortTimingClass(const CellInfo *cell, IdString port, int &clockInfoCount) const
{
    if (cell->type == id_LUT4) {
        if (port == id_CLK)
            return TMG_CLOCK_INPUT;
        if (port == id_CIN)
            return TMG_COMB_INPUT;
        if (port == id_COUT)
            return TMG_COMB_OUTPUT;
        if (port == id_O) {
            // LCs with no inputs are constant drivers
            if (cell->lcInfo.inputCount == 0)
                return TMG_IGNORE;
            return TMG_COMB_OUTPUT;
        }
        if (cell->lcInfo.dffEnable) {
            clockInfoCount = 1;
            if (port == id_OQ)
                return TMG_REGISTER_OUTPUT;
            return TMG_REGISTER_INPUT;
        } else {
            return TMG_COMB_INPUT;
        }
        // TODO
        // if (port == id_OMUX)
    } else if (cell->type == id_IOB33 || cell->type == id_IOB18 || cell->type==id_IOBUF) {
        if (port == id_I)
            return TMG_STARTPOINT;
        else if (port == id_O)
            return TMG_ENDPOINT;
    } else if (cell->type == id_BUFGCTRL) {
        if (port == id_O)
            return TMG_COMB_OUTPUT;
        return TMG_COMB_INPUT;
    } else if (cell->type == id_PS7) {
        // TODO
        return TMG_IGNORE;
    } else if (cell->type == id_MMCME2_ADV) {
        return TMG_IGNORE;
    } else if ((cell->type == id("MUXF7") || cell->type == id("MUXF8"))){
    	if (port == id_O){
    		return TMG_COMB_OUTPUT;
    	} else {
    		return TMG_COMB_INPUT;
    	}
    } else if (cell->type == id("diko_MULADD")){
        if (port.c_str(this)[0] == 'Q') {
            return TMG_COMB_OUTPUT;
        } else {
            return TMG_COMB_INPUT;
        }
    } else if (cell->type == this->id("InPass4_frame_config")){
    	return TMG_STARTPOINT;
    } else if (cell->type == this->id("OutPass4_frame_config")){
    	return TMG_ENDPOINT;
    } else 
    log_error("no timing info for port '%s' of cell type '%s', with cell name '%s'\n", port.c_str(this), cell->type.c_str(this), cell->name.c_str(this));
}

TimingClockingInfo Arch::getPortClockingInfo(const CellInfo *cell, IdString port, int index) const
{
    TimingClockingInfo info;
    if (cell->type == id_LUT4) {
        info.clock_port = id_CLK;
        info.edge = cell->lcInfo.negClk ? FALLING_EDGE : RISING_EDGE;
        if (port == id_OQ) {
            bool has_clktoq = getCellDelay(cell, id_CLK, id_OQ, info.clockToQ);
            NPNR_ASSERT(has_clktoq);
        } else {
            info.setup.delay = 124; // Tilo
            info.hold.delay = 0;
        }
    } else {
        NPNR_ASSERT_FALSE("unhandled cell type in getPortClockingInfo");
    }
    return info;
}

bool Arch::isGlobalNet(const NetInfo *net) const
{
    if (net == nullptr)
        return false;
    return net->driver.cell != nullptr && net->driver.cell->type == id_BUFGCTRL && net->driver.port == id_O;
}

// Assign arch arg info
void Arch::assignArchInfo()
{
    for (auto &net : getCtx()->nets) {
        NetInfo *ni = net.second.get();
        if (isGlobalNet(ni))
            ni->is_global = true;
        ni->is_enable = false;
        ni->is_reset = false;
        for (auto usr : ni->users) {
            if (is_enable_port(this, usr))
                ni->is_enable = true;
            if (is_reset_port(this, usr))
                ni->is_reset = true;
        }
    }
    for (auto &cell : getCtx()->cells) {
        CellInfo *ci = cell.second.get();
        assignCellInfo(ci);
    }
}

void Arch::assignCellInfo(CellInfo *cell)
{
    cell->belType = cell->type;
    if (cell->type == id_LUT4) {
        cell->lcInfo.dffEnable = bool_or_default(cell->params, id_DFF_ENABLE);
        cell->lcInfo.carryEnable = bool_or_default(cell->params, id_CARRY_ENABLE);
        cell->lcInfo.negClk = bool_or_default(cell->params, id_NEG_CLK);
        cell->lcInfo.clk = get_net_or_empty(cell, id_CLK);
        cell->lcInfo.cen = get_net_or_empty(cell, id_CEN);
        cell->lcInfo.sr = get_net_or_empty(cell, id_SR);
        cell->lcInfo.inputCount = 0;
        if (get_net_or_empty(cell, id_I0))
            cell->lcInfo.inputCount++;
        if (get_net_or_empty(cell, id_I1))
            cell->lcInfo.inputCount++;
        if (get_net_or_empty(cell, id_I2))
            cell->lcInfo.inputCount++;
        if (get_net_or_empty(cell, id_I3))
            cell->lcInfo.inputCount++;
        //if (get_net_or_empty(cell, id_I5))
        //    cell->lcInfo.inputCount++;
        //if (get_net_or_empty(cell, id_I6))
        //    cell->lcInfo.inputCount++;
    }
}

NEXTPNR_NAMESPACE_END
