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
#include "xdl.h"
#include <cctype>
#include <vector>
#include "cells.h"
#include "log.h"
#include "nextpnr.h"
#include "util.h"
#include <boost/range/adaptor/reversed.hpp>
#include <boost/lexical_cast.hpp>

NEXTPNR_NAMESPACE_BEGIN

void write_fasm(const Context *ctx, std::ostream &out)
{
    for (const auto &cell : ctx->cells) {
        if (cell.second->type == id_LUT4) {
            const auto &init = cell.second->params.at(ctx->id("INIT"));
            if (init.empty()) continue;
            auto it = cell.second->params.find(ctx->id("LUT_NAME"));
            if (it != cell.second->params.end())
                out << "# Cell: " << it->second << std::endl;
            else
                out << "# Cell: " << cell.second->name.str(ctx) << std::endl;
            if (cell.second->lcInfo.inputCount <= 5) { 
                auto num_bits = (1 << cell.second->lcInfo.inputCount);
                auto init_as_uint = boost::lexical_cast<uint32_t>(init);
                out << ctx->getBelName(cell.second->bel).str(ctx) << ".INIT";
                out << "[" << num_bits-1 << ":0]" << "=";
                out << num_bits << "'b";
                for (auto i = 0; i < num_bits; ++i)
                    out << ((init_as_uint >> i) & 1 ? '1' : '0');
                out << std::endl;
            }
            else {
                out << ctx->getBelName(cell.second->bel).str(ctx) << ".INIT[7:0]=";
                out << "32'b" << boost::adaptors::reverse(init.substr(0,8)) << std::endl;
                out << ctx->getBelName(cell.second->bel).str(ctx) << ".INIT[15:8]=";
                out << "32'b" << boost::adaptors::reverse(init.substr(8,32)) << std::endl;
            }
            //if (cell.second->lcInfo.dffEnable)
            //    out << ctx->getBelName(cell.second->bel).str(ctx) << ".#FF" <<std::endl;
        } else if (cell.second->type == id_IOBUF){
		out << "#IO Buffer" << std::endl;
        }
        else
            log_error("Unsupported cell type '%s'.\n", cell.second->type.c_str(ctx));
    for (auto &param: cell.second->params){
        auto paramName = param.first.str(ctx);
        if (param.second == "1"  && paramName != "INIT"){
            out << ctx->getBelName(cell.second->bel).str(ctx) << "." << paramName << std::endl;
        }
    }
    }


    for (const auto &net : ctx->nets) {
        out << "# Net: " << net.second->name.str(ctx) << std::endl;
        for (const auto &i : net.second->wires) {
                const auto &pip_map = i.second;
                if (pip_map.pip == PipId())
                    continue;
                out << chip_info->tile_to_name[chip_info->wire_to_tile[ctx->getPipDstWire(pip_map.pip).index]].str(ctx) << ".";
                out << chip_info->pip_to_txt.at(pip_map.pip.index) << std::endl;
        }
    }

}

NEXTPNR_NAMESPACE_END
