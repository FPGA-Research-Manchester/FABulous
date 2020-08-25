/*
 *  nextpnr -- Next Generation Place and Route
 *
 *  Copyright (C) 2018  Clifford Wolf <clifford@symbioticeda.com>
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

#ifndef NEXTPNR_H
#error Include "arch.h" via "nextpnr.h" only.
#endif

#include <boost/container/flat_map.hpp>
#include <boost/algorithm/string/replace.hpp>

NEXTPNR_NAMESPACE_BEGIN

struct ChipInfo
{
    ChipInfo(BaseCtx *ctx);
    ChipInfo() = delete;

    typedef unsigned TileId;
    std::vector<IdString> tile_to_name;
    std::vector<std::pair<int,int>> tile_to_xy;

    std::vector<TileId> bel_to_tile;
    std::vector<IdString> bel_to_name;
    std::vector<IdString> bel_to_type;
    std::vector<Loc> bel_to_loc;
    std::vector<boost::container::flat_map<IdString,WireId>> bel_to_pin_wire;
    int num_bels;
    //std::vector<BelId> site_index_to_bel;
    //std::vector<IdString> site_index_to_type;
    //std::vector<Loc> bel_to_loc;
    //std::unordered_map<Segments::SegmentReference, WireId> segment_to_wire;
    //std::unordered_map<Tilewire, WireId> trivial_to_wire;
    std::vector<IdString> wire_to_name;
    std::vector<TileId> wire_to_tile;
    int num_wires;
    //std::vector<DelayInfo> wire_to_delay;
    //std::vector<std::vector<int>> wire_to_pips_uphill;
    std::vector<std::vector<PipId>> wire_to_pips_downhill;
    //std::vector<Arc> pip_to_arc;
    //std::vector<TileId> pip_to_tile;
    std::vector<std::pair<WireId,WireId>> pip_to_src_dst;
    int num_pips;
    int width;
    int height;
    //std::vector<bool> wire_is_global;
    //std::vector<std::pair<int,int>> tile_to_xy;
    std::vector<std::string> pip_to_txt;
    std::vector<DelayInfo> pip_to_delay;
};
extern std::unique_ptr<const ChipInfo> chip_info;

struct BelIterator
{
    int cursor;

    BelIterator operator++()
    {
        cursor++;
        return *this;
    }
    BelIterator operator++(int)
    {
        BelIterator prior(*this);
        cursor++;
        return prior;
    }

    bool operator!=(const BelIterator &other) const { return cursor != other.cursor; }

    bool operator==(const BelIterator &other) const { return cursor == other.cursor; }

    BelId operator*() const
    {
        BelId ret;
        ret.index = cursor;
        return ret;
    }
};

struct BelRange
{
    BelIterator b, e;
    BelIterator begin() const { return b; }
    BelIterator end() const { return e; }
};

// -----------------------------------------------------------------------

struct BelPinIterator
{
    const BelId bel;
    //Array<const WireIndex>::iterator it;

    void operator++() { /*it++;*/ }
    bool operator!=(const BelPinIterator &other) const { return /*it != other.it &&*/ bel != other.bel; }

    BelPin operator*() const
    {
        BelPin ret;
        ret.bel = bel;
        ret.pin = IdString();
        return ret;
    }
};

struct BelPinRange
{
    BelPinIterator b, e;
    BelPinIterator begin() const { return b; }
    BelPinIterator end() const { return e; }
};

// -----------------------------------------------------------------------

struct WireIterator
{
    int cursor = -1;

    void operator++() { cursor++; }
    bool operator!=(const WireIterator &other) const { return cursor != other.cursor; }

    WireId operator*() const
    {
        WireId ret;
        ret.index = cursor;
        return ret;
    }
};

struct WireRange
{
    WireIterator b, e;
    WireIterator begin() const { return b; }
    WireIterator end() const { return e; }
};

// -----------------------------------------------------------------------

struct AllPipIterator
{
    int cursor = -1;

    void operator++() { cursor++; }
    bool operator!=(const AllPipIterator &other) const { return cursor != other.cursor; }

    PipId operator*() const
    {
        PipId ret;
        ret.index = cursor;
        return ret;
    }
};

struct AllPipRange
{
    AllPipIterator b, e;
    AllPipIterator begin() const { return b; }
    AllPipIterator end() const { return e; }
};

// -----------------------------------------------------------------------

struct PipIterator
{
    const PipId *cursor = nullptr;

    void operator++() { cursor++; }
    bool operator!=(const PipIterator &other) const { return cursor != other.cursor; }

    PipId operator*() const
    {
        return *cursor;
    }
};

struct PipRange
{
    PipIterator b, e;
    PipIterator begin() const { return b; }
    PipIterator end() const { return e; }
};

struct ArchArgs
{
    enum ArchArgsTypes
    {
        NONE,
        Z020,
        VX980
    } type = NONE;
    std::string package;
};

struct Arch : BaseCtx
{
    int width;
    int height;

    mutable std::unordered_map<IdString, int> wire_by_name;
    mutable std::unordered_map<IdString, int> pip_by_name;
    mutable std::unordered_map<Loc, BelId> bel_by_loc;

    // std::vector<bool> bel_carry;
    std::vector<CellInfo *> bel_to_cell;
    std::vector<NetInfo *> wire_to_net;
    std::vector<NetInfo *> pip_to_net;
    // std::vector<NetInfo *> switches_locked;

    ArchArgs args;
    Arch(ArchArgs args);

    std::string getChipName() const;

    IdString archId() const { return id("xc7"); }
    ArchArgs archArgs() const { return args; }
    IdString archArgsToId(ArchArgs args) const;

    // -------------------------------------------------

    int getGridDimX() const { return width; }
    int getGridDimY() const { return height; }
    int getTileBelDimZ(int, int) const { return 8; }
    int getTilePipDimZ(int, int) const { return 1; }

    // -------------------------------------------------

    BelId getBelByName(IdString name) const;

    IdString getBelName(BelId bel) const
    {
        NPNR_ASSERT(bel != BelId());
        std::stringstream bel_name;
        bel_name << chip_info->tile_to_name[chip_info->bel_to_tile[bel.index]].str(this);
        bel_name << ".";
        bel_name << chip_info->bel_to_name[bel.index].str(this);
        return id(bel_name.str());
    }

    uint32_t getBelChecksum(BelId bel) const { return bel.index; }

    void bindBel(BelId bel, CellInfo *cell, PlaceStrength strength)
    {
        NPNR_ASSERT(bel != BelId());
        NPNR_ASSERT(bel_to_cell[bel.index] == nullptr);

        bel_to_cell[bel.index] = cell;
        // bel_carry[bel.index] = (cell->type == id_ICESTORM_LC && cell->lcInfo.carryEnable);
        cell->bel = bel;
        cell->belStrength = strength;
        refreshUiBel(bel);
    }

    void unbindBel(BelId bel)
    {
        NPNR_ASSERT(bel != BelId());
        NPNR_ASSERT(bel_to_cell[bel.index] != nullptr);
        bel_to_cell[bel.index]->bel = BelId();
        bel_to_cell[bel.index]->belStrength = STRENGTH_NONE;
        bel_to_cell[bel.index] = nullptr;
        // bel_carry[bel.index] = false;
        refreshUiBel(bel);
    }

    bool checkBelAvail(BelId bel) const
    {
        NPNR_ASSERT(bel != BelId());
        return bel_to_cell[bel.index] == nullptr;
    }

    CellInfo *getBoundBelCell(BelId bel) const
    {
        NPNR_ASSERT(bel != BelId());
        return bel_to_cell[bel.index];
    }

    CellInfo *getConflictingBelCell(BelId bel) const
    {
        NPNR_ASSERT(bel != BelId());
        return bel_to_cell[bel.index];
    }

    BelRange getBels() const
    {
        BelRange range;
        range.b.cursor = 0;
        range.e.cursor = chip_info->num_bels;
        return range;
    }

    Loc getBelLocation(BelId bel) const { return chip_info->bel_to_loc[bel.index]; }

    BelId getBelByLocation(Loc loc) const;
    BelRange getBelsByTile(int x, int y) const;

    bool getBelGlobalBuf(BelId bel) const { return getBelType(bel) == id_BUFGCTRL; }

    IdString getBelType(BelId bel) const
    {
        NPNR_ASSERT(bel != BelId());
        return chip_info->bel_to_type[bel.index];
    }

    std::vector<std::pair<IdString, std::string>> getBelAttrs(BelId bel) const;

    WireId getBelPinWire(BelId bel, IdString pin) const;
    PortType getBelPinType(BelId bel, IdString pin) const;
    std::vector<IdString> getBelPins(BelId bel) const;

    // -------------------------------------------------

    WireId getWireByName(IdString name) const;

    IdString getWireName(WireId wire) const
    {
        NPNR_ASSERT(wire != WireId());
        std::stringstream wire_name;
        wire_name << chip_info->tile_to_name[chip_info->wire_to_tile[wire.index]].str(this);
        wire_name << ".";
        wire_name << chip_info->wire_to_name[wire.index].str(this);
        return id(wire_name.str());
    }

    IdString getWireType(WireId wire) const;
    std::vector<std::pair<IdString, std::string>> getWireAttrs(WireId wire) const;

    uint32_t getWireChecksum(WireId wire) const { return wire.index; }

    void bindWire(WireId wire, NetInfo *net, PlaceStrength strength)
    {
        NPNR_ASSERT(wire != WireId());
        NPNR_ASSERT(wire_to_net[wire.index] == nullptr);
        wire_to_net[wire.index] = net;
        net->wires[wire].pip = PipId();
        net->wires[wire].strength = strength;
        refreshUiWire(wire);
    }

    void unbindWire(WireId wire)
    {
        NPNR_ASSERT(wire != WireId());
        NPNR_ASSERT(wire_to_net[wire.index] != nullptr);

        auto &net_wires = wire_to_net[wire.index]->wires;
        auto it = net_wires.find(wire);
        NPNR_ASSERT(it != net_wires.end());

        auto pip = it->second.pip;
        if (pip != PipId()) {
            pip_to_net[pip.index] = nullptr;
        }

        net_wires.erase(it);
        wire_to_net[wire.index] = nullptr;
        refreshUiWire(wire);
    }

    bool checkWireAvail(WireId wire) const
    {
        NPNR_ASSERT(wire != WireId());
        return wire_to_net[wire.index] == nullptr;
    }

    NetInfo *getBoundWireNet(WireId wire) const
    {
        NPNR_ASSERT(wire != WireId());
        return wire_to_net[wire.index];
    }

    WireId getConflictingWireWire(WireId wire) const { return wire; }

    NetInfo *getConflictingWireNet(WireId wire) const
    {
        NPNR_ASSERT(wire != WireId());
        return wire_to_net[wire.index];
    }

    DelayInfo getWireDelay(WireId wire) const { return {}; }

    BelPinRange getWireBelPins(WireId wire) const
    {
        BelPinRange range;
        // TODO
        return range;
    }

    WireRange getWires() const
    {
        WireRange range;
        range.b.cursor = 0;
        range.e.cursor = chip_info->num_wires;
        return range;
    }

    // -------------------------------------------------

    PipId getPipByName(IdString name) const;

    void bindPip(PipId pip, NetInfo *net, PlaceStrength strength)
    {
        NPNR_ASSERT(pip != PipId());
        NPNR_ASSERT(pip_to_net[pip.index] == nullptr);

        pip_to_net[pip.index] = net;

        WireId dst = getPipDstWire(pip);
        NPNR_ASSERT(wire_to_net[dst.index] == nullptr);
        wire_to_net[dst.index] = net;
        net->wires[dst].pip = pip;
        net->wires[dst].strength = strength;
        refreshUiPip(pip);
        refreshUiWire(dst);
    }

    void unbindPip(PipId pip)
    {
        NPNR_ASSERT(pip != PipId());
        NPNR_ASSERT(pip_to_net[pip.index] != nullptr);

        WireId dst = getPipDstWire(pip);
        NPNR_ASSERT(wire_to_net[dst.index] != nullptr);
        wire_to_net[dst.index] = nullptr;
        pip_to_net[pip.index]->wires.erase(dst);

        pip_to_net[pip.index] = nullptr;
        refreshUiPip(pip);
        refreshUiWire(dst);
    }

    bool checkPipAvail(PipId pip) const
    {
        NPNR_ASSERT(pip != PipId());
        return pip_to_net[pip.index] == nullptr;
    }

    NetInfo *getBoundPipNet(PipId pip) const
    {
        NPNR_ASSERT(pip != PipId());
        return pip_to_net[pip.index];
    }

    WireId getConflictingPipWire(PipId pip) const { return WireId(); }

    NetInfo *getConflictingPipNet(PipId pip) const
    {
        NPNR_ASSERT(pip != PipId());
        return pip_to_net[pip.index];
    }

    AllPipRange getPips() const
    {
        AllPipRange range;
        range.b.cursor = 0;
        range.e.cursor = chip_info->num_pips;
        return range;
    }

    Loc getPipLocation(PipId pip) const
    {
        Loc loc;
        NPNR_ASSERT("TODO");
        return loc;
    }

    IdString getPipName(PipId pip) const;

    IdString getPipType(PipId pip) const { return IdString(); }
    std::vector<std::pair<IdString, std::string>> getPipAttrs(PipId pip) const;

    uint32_t getPipChecksum(PipId pip) const { return pip.index; }

    WireId getPipSrcWire(PipId pip) const
    {
        NPNR_ASSERT(pip != PipId());
        return chip_info->pip_to_src_dst[pip.index].first;
    }

    WireId getPipDstWire(PipId pip) const
    {
        NPNR_ASSERT(pip != PipId());
        return chip_info->pip_to_src_dst[pip.index].second;
    }

    DelayInfo getPipDelay(PipId pip) const
    {
        NPNR_ASSERT(pip != PipId());
        return chip_info->pip_to_delay[pip.index];
    }

    PipRange getPipsDownhill(WireId wire) const
    {
        PipRange range;
        NPNR_ASSERT(wire != WireId());
        const auto &pips = chip_info->wire_to_pips_downhill[wire.index];
        range.b.cursor = pips.data();
        range.e.cursor = range.b.cursor + pips.size();
        return range;
    }

    PipRange getPipsUphill(WireId wire) const
    {
        PipRange range;
         NPNR_ASSERT(wire != WireId());
        // const auto &pips = chip_info->wire_to_pips_uphill[wire.index];
        // range.b.cursor = pips.data();
        // range.e.cursor = range.b.cursor + pips.size();
        return range;
    }

    PipRange getWireAliases(WireId wire) const
    {
        PipRange range;
        NPNR_ASSERT(wire != WireId());
        range.b.cursor = nullptr;
        range.e.cursor = nullptr;
        return range;
    }

    BelId getPackagePinBel(const std::string &pin) const;
    std::string getBelPackagePin(BelId bel) const;

    // -------------------------------------------------

    GroupId getGroupByName(IdString name) const;
    IdString getGroupName(GroupId group) const;
    std::vector<GroupId> getGroups() const;
    std::vector<BelId> getGroupBels(GroupId group) const;
    std::vector<WireId> getGroupWires(GroupId group) const;
    std::vector<PipId> getGroupPips(GroupId group) const;
    std::vector<GroupId> getGroupGroups(GroupId group) const;

    // -------------------------------------------------

    delay_t estimateDelay(WireId src, WireId dst) const;
    delay_t predictDelay(const NetInfo *net_info, const PortRef &sink) const;
    delay_t getDelayEpsilon() const { return 20; }
    delay_t getRipupDelayPenalty() const { return 200; }
    float getDelayNS(delay_t v) const { return v * 0.001; }

    DelayInfo getDelayFromNS(float ns) const
    {
        DelayInfo del;
        del.delay = delay_t(ns * 1000);
        return del;
    }

    uint32_t getDelayChecksum(delay_t v) const { return v; }
    bool getBudgetOverride(const NetInfo *net_info, const PortRef &sink, delay_t &budget) const;

    // -------------------------------------------------

    bool pack();
    bool place();
    bool route();

    // -------------------------------------------------

    std::vector<GraphicElement> getDecalGraphics(DecalId decal) const;

    DecalXY getBelDecal(BelId bel) const;
    DecalXY getWireDecal(WireId wire) const;
    DecalXY getPipDecal(PipId pip) const;
    DecalXY getGroupDecal(GroupId group) const;

    // -------------------------------------------------

    // Get the delay through a cell from one port to another, returning false
    // if no path exists
    bool getCellDelay(const CellInfo *cell, IdString fromPort, IdString toPort, DelayInfo &delay) const;
    // Get the port class, also setting clockDomain if applicable
    TimingPortClass getPortTimingClass(const CellInfo *cell, IdString port, int &clockInfoCount) const;
    // Get the TimingClockingInfo of a port
    TimingClockingInfo getPortClockingInfo(const CellInfo *cell, IdString port, int index) const;
    // Return true if a port is a net
    bool isGlobalNet(const NetInfo *net) const;

    // -------------------------------------------------

    // Perform placement validity checks, returning false on failure (all
    // implemented in arch_place.cc)

    // Whether or not a given cell can be placed at a given Bel
    // This is not intended for Bel type checks, but finer-grained constraints
    // such as conflicting set/reset signals, etc
    bool isValidBelForCell(CellInfo *cell, BelId bel) const;

    // Return true whether all Bels at a given location are valid
    bool isBelLocationValid(BelId bel) const;

    // Helper function for above
    bool logicCellsCompatible(const CellInfo **it, const size_t size) const;

    // -------------------------------------------------
    // Assign architecure-specific arguments to nets and cells, which must be
    // called between packing or further
    // netlist modifications, and validity checks
    void assignArchInfo();
    void assignCellInfo(CellInfo *cell);

    // -------------------------------------------------
    BelPin getIOBSharingPLLPin(BelId pll, IdString pll_pin) const
    {
        auto wire = getBelPinWire(pll, pll_pin);
        for (auto src_bel : getWireBelPins(wire)) {
            if (getBelType(src_bel.bel) == id_SB_IO && src_bel.pin == id_D_IN_0) {
                return src_bel;
            }
        }
        NPNR_ASSERT_FALSE("Expected PLL pin to share an output with an SB_IO D_IN_{0,1}");
    }

    float placer_constraintWeight = 10;
};

NEXTPNR_NAMESPACE_END
