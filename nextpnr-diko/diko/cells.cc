/*
 *  nextpnr -- Next Generation Place and Route
 *
 *  Copyright (C) 2018  Clifford Wolf <clifford@symbioticeda.com>
 *  Copyright (C) 2018  David Shah <david@symbioticeda.com>
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

#include "cells.h"
#include "design_utils.h"
#include "log.h"
#include "util.h"

NEXTPNR_NAMESPACE_BEGIN

void add_port(const Context *ctx, CellInfo *cell, std::string name, PortType dir)
{
    IdString id = ctx->id(name);
    cell->ports[id] = PortInfo{id, nullptr, dir};
}

std::unique_ptr<CellInfo> create_diko_cell(Context *ctx, IdString type, std::string name)
{
    static int auto_idx = 0;
    std::unique_ptr<CellInfo> new_cell = std::unique_ptr<CellInfo>(new CellInfo());
    if (name.empty()) {
        new_cell->name = ctx->id("$nextpnr_" + type.str(ctx) + "_" + std::to_string(auto_idx++));
    } else {
        new_cell->name = ctx->id(name);
    }
    new_cell->type = type;
    if (type == ctx->id("diko_LC")) {
        new_cell->type = id_LUT4;
        new_cell->params[ctx->id("INIT")] = "0";
        new_cell->params[ctx->id("NEG_CLK")] = "0";
        new_cell->params[ctx->id("CARRY_ENABLE")] = "0";
        new_cell->params[ctx->id("DFF_ENABLE")] = "0";
        new_cell->params[ctx->id("CIN_CONST")] = "0";
        new_cell->params[ctx->id("CIN_SET")] = "0";

        add_port(ctx, new_cell.get(), "I0", PORT_IN);
        add_port(ctx, new_cell.get(), "I1", PORT_IN);
        add_port(ctx, new_cell.get(), "I2", PORT_IN);
        add_port(ctx, new_cell.get(), "I3", PORT_IN);
        //add_port(ctx, new_cell.get(), "I5", PORT_IN);
        //add_port(ctx, new_cell.get(), "I6", PORT_IN);
        add_port(ctx, new_cell.get(), "CIN", PORT_IN);

        add_port(ctx, new_cell.get(), "CLK", PORT_IN);
        add_port(ctx, new_cell.get(), "CE", PORT_IN);
        add_port(ctx, new_cell.get(), "SR", PORT_IN);

        add_port(ctx, new_cell.get(), "O", PORT_OUT);
        //add_port(ctx, new_cell.get(), "OQ", PORT_OUT);
        add_port(ctx, new_cell.get(), "OMUX", PORT_OUT);
        add_port(ctx, new_cell.get(), "COUT", PORT_OUT);
    } else if (type == ctx->id("diko_mux")){
        add_port(ctx, new_cell.get(), "O", PORT_OUT);
        add_port(ctx, new_cell.get(), "I0", PORT_IN);
        add_port(ctx, new_cell.get(), "I1", PORT_IN);
        add_port(ctx, new_cell.get(), "S", PORT_IN);
    } else if (type == ctx->id("IOBUF")) {
	    //if (ctx->args.type == ArchArgs::Z020)
		//    new_cell->type = id_IOB33;
	    //else
		 //   new_cell->type = id_IOB18;
        new_cell->type = ctx->id("IOBUF");
        add_port(ctx, new_cell.get(), "I", PORT_OUT);
        add_port(ctx, new_cell.get(), "O", PORT_IN);
    } else if (type == ctx->id("InPass4_frame_config")) {
        new_cell->type = ctx->id("InPass4_frame_config");
        add_port(ctx, new_cell.get(), "O[0]", PORT_OUT);
        add_port(ctx, new_cell.get(), "O[1]", PORT_OUT);
        add_port(ctx, new_cell.get(), "O[2]", PORT_OUT);
        add_port(ctx, new_cell.get(), "O[3]", PORT_OUT);
    } else if (type == ctx->id("OutPass4_frame_config")) {
        new_cell->type = ctx->id("OutPass4_frame_config");
        add_port(ctx, new_cell.get(), "I[0]", PORT_IN);
        add_port(ctx, new_cell.get(), "I[1]", PORT_IN);
        add_port(ctx, new_cell.get(), "I[2]", PORT_IN);
        add_port(ctx, new_cell.get(), "I[3]", PORT_IN);
    } else if (type == id_BUFGCTRL) {
        add_port(ctx, new_cell.get(), "I0", PORT_IN);
        add_port(ctx, new_cell.get(), "O", PORT_OUT);
    } else if (type == ctx->id("diko_MULADD")){
    	new_cell->params[ctx->id("A_reg")] = "0";
        new_cell->params[ctx->id("B_reg")] = "0";
        new_cell->params[ctx->id("C_reg")] = "0";

        add_port(ctx, new_cell.get(), "A[0]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[1]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[2]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[3]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[4]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[5]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[6]", PORT_IN);
        add_port(ctx, new_cell.get(), "A[7]", PORT_IN);

        add_port(ctx, new_cell.get(), "B[0]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[1]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[2]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[3]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[4]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[5]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[6]", PORT_IN);
        add_port(ctx, new_cell.get(), "B[7]", PORT_IN);

        add_port(ctx, new_cell.get(), "Q[0]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[1]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[2]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[3]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[4]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[5]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[6]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[7]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[8]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[9]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[10]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[11]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[12]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[13]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[14]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[15]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[16]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[17]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[18]", PORT_OUT);
        add_port(ctx, new_cell.get(), "Q[19]", PORT_OUT);
        add_port(ctx, new_cell.get(), "clr", PORT_IN);

        add_port(ctx, new_cell.get(), "C[0]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[1]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[2]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[3]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[4]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[5]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[6]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[7]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[8]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[9]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[10]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[11]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[12]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[13]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[14]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[15]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[16]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[17]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[18]", PORT_IN);
        add_port(ctx, new_cell.get(), "C[19]", PORT_IN);

        // add_port(ctx, new_cell.get(), "A", PORT_IN);
        // add_port(ctx, new_cell.get(), "B", PORT_IN);
        // add_port(ctx, new_cell.get(), "C", PORT_IN);
        // add_port(ctx, new_cell.get(), "Q", PORT_OUT);
    } else {
        log_error("unable to create diko cell of type %s\n", type.c_str(ctx));
    }
    return new_cell;
}

void lut_to_lc(const Context *ctx, CellInfo *lut, CellInfo *lc, bool no_dff)
{
    lc->params[ctx->id("INIT")] = lut->params[ctx->id("INIT")];
    int i = 3;
    //if (get_net_or_empty(lut, id_I5))
    //    replace_port(lut, id_I5, lc, ctx->id("I" + std::to_string(i--)));
    //if (get_net_or_empty(lut, id_I4))
    //    replace_port(lut, id_I4, lc, ctx->id("I" + std::to_string(i--)));
    if (get_net_or_empty(lut, id_I3))
        replace_port(lut, id_I3, lc, ctx->id("I3"));
    if (get_net_or_empty(lut, id_I2))
        replace_port(lut, id_I2, lc, ctx->id("I2"));
    if (get_net_or_empty(lut, id_I1))
        replace_port(lut, id_I1, lc, ctx->id("I1"));
    if (get_net_or_empty(lut, ctx->id("I0")))
        replace_port(lut, ctx->id("I0"), lc, ctx->id("I0"));

    if (no_dff) {
        if (get_net_or_empty(lut, id_O))
            replace_port(lut, id_O, lc, id_O);
        lc->params[ctx->id("DFF_ENABLE")] = "0";
    }
    lc->params[ctx->id("LUT_NAME")] = lut->name.str(ctx);
}

void dff_to_lc(const Context *ctx, CellInfo *dff, CellInfo *lc, bool pass_thru_lut)
{
    lc->params[ctx->id("DFF_ENABLE")] = "1";
    std::string config = dff->type.str(ctx).substr(2);
    auto citer = config.begin();
    //replace_port(dff, ctx->id("C"), lc, id_CLK);
    if (get_net_or_empty(dff, ctx->id("C")))
            disconnect_port(ctx, dff, ctx->id("C"));

    if (citer != config.end()) {
        auto gnd_net = ctx->nets.at(ctx->id("$PACKER_GND_NET")).get();

        if (*citer == 'S') {
            citer++;
            if (get_net_or_empty(dff, id_S) != gnd_net) {
                lc->params[id_SR] = "SRHIGH";
                //replace_port(dff, id_S, lc, id_SR);
                disconnect_port(ctx, dff, id_S);
            }
            else
                disconnect_port(ctx, dff, id_S);
            lc->params[ctx->id("SYNC_ATTR")] = "SYNC";
        } else if (*citer == 'R') {
            citer++;
            if (get_net_or_empty(dff, id_R) != gnd_net) {
                lc->params[id_SR] = "SRLOW";
                //replace_port(dff, id_R, lc, id_SR);
                disconnect_port(ctx, dff, id_R);
            }
            else
                disconnect_port(ctx, dff, id_R);
            lc->params[ctx->id("SYNC_ATTR")] = "SYNC";
        } else if (*citer == 'C') {
            citer++;
            if (get_net_or_empty(dff, id_CLR) != gnd_net) {
                lc->params[id_SR] = "SRLOW";
                //replace_port(dff, id_CLR, lc, id_SR);
                disconnect_port(ctx, dff, id_CLR);
            }
            else
                disconnect_port(ctx, dff, id_CLR);
            lc->params[ctx->id("SYNC_ATTR")] = "ASYNC";
        } else {
            NPNR_ASSERT(*citer == 'P');
            citer++;
            if (get_net_or_empty(dff, id_PRE) != gnd_net) {
                lc->params[id_SR] = "SRHIGH";
                //replace_port(dff, id_PRE, lc, id_SR);
                disconnect_port(ctx, dff, id_PRE);
            }
            else
                disconnect_port(ctx, dff, id_PRE);
            lc->params[ctx->id("SYNC_ATTR")] = "ASYNC";
        }
    }

    if (citer != config.end() && *citer == 'E') {
        //auto vcc_net = ctx->nets.at(ctx->id("$PACKER_VCC_NET")).get();

        ++citer;
        //if (get_net_or_empty(dff, ctx->id("CE")) != vcc_net)
        //    replace_port(dff, ctx->id("CE"), lc, ctx->id("CE"));
        //else
            disconnect_port(ctx, dff, ctx->id("CE"));
    }

    NPNR_ASSERT(citer == config.end());

    if (pass_thru_lut) {
        lc->params[ctx->id("INIT")] = "2";
        replace_port(dff, ctx->id("D"), lc, id_I1);
    }

    //replace_port(dff, ctx->id("Q"), lc, id_OQ);

    auto it = dff->params.find(ctx->id("INIT"));
    if (it != dff->params.end())
        lc->params[ctx->id("FFINIT")] = it->second == "1" ? "INIT1" : "INIT0";
}

void nxio_to_sb(Context *ctx, CellInfo *nxio, CellInfo *sbio)
{
    if (nxio->type == ctx->id("$nextpnr_ibuf")) {
        sbio->params[ctx->id("PIN_TYPE")] = "1";
        auto pu_attr = nxio->attrs.find(ctx->id("PULLUP"));
        if (pu_attr != nxio->attrs.end())
            sbio->params[ctx->id("PULLUP")] = pu_attr->second;
        replace_port(nxio, id_O, sbio, id_I);
    } else if (nxio->type == ctx->id("$nextpnr_obuf")) {
        sbio->params[ctx->id("PIN_TYPE")] = "25";
        replace_port(nxio, id_I, sbio, id_O);
    } else if (nxio->type == ctx->id("$nextpnr_iobuf")) {
        // N.B. tristate will be dealt with below
        sbio->params[ctx->id("PIN_TYPE")] = "25";
        replace_port(nxio, id_I, sbio, id_O);
        replace_port(nxio, id_O, sbio, id_I);
    } else {
        NPNR_ASSERT(false);
    }
    NetInfo *donet = sbio->ports.at(id_O).net;
    CellInfo *tbuf = net_driven_by(
            ctx, donet, [](const Context *ctx, const CellInfo *cell) { return cell->type == ctx->id("$_TBUF_"); },
            ctx->id("Y"));
    if (tbuf) {
        sbio->params[ctx->id("PIN_TYPE")] = "41";
        replace_port(tbuf, ctx->id("A"), sbio, id_O);
        replace_port(tbuf, ctx->id("E"), sbio, ctx->id("OUTPUT_ENABLE"));
        ctx->nets.erase(donet->name);
        if (!donet->users.empty())
            log_error("unsupported tristate IO pattern for IO buffer '%s', "
                      "instantiate SB_IO manually to ensure correct behaviour\n",
                      nxio->name.c_str(ctx));
        ctx->cells.erase(tbuf->name);
    }
}

bool is_clock_port(const BaseCtx *ctx, const PortRef &port)
{
    if (port.cell == nullptr)
        return false;
    NPNR_ASSERT("TODO");
    return false;
}

bool is_reset_port(const BaseCtx *ctx, const PortRef &port)
{
    if (port.cell == nullptr)
        return false;
    NPNR_ASSERT("TODO");
    return false;
}

bool is_enable_port(const BaseCtx *ctx, const PortRef &port)
{
    if (port.cell == nullptr)
        return false;
    NPNR_ASSERT("TODO");
    return false;
}

NEXTPNR_NAMESPACE_END
