// verilator lint_off WIDTHEXPAND
// verilator lint_off WIDTHTRUNC
/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Author: Eyal Hochberg                                      ////
////          eyal@provartec.com                                 ////
////                                                             ////
////  Downloaded from: http://www.opencores.org                  ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2010 Provartec LTD                            ////
//// www.provartec.com                                           ////
//// info@provartec.com                                          ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
//// This source file is free software; you can redistribute it  ////
//// and/or modify it under the terms of the GNU Lesser General  ////
//// Public License as published by the Free Software Foundation.////
////                                                             ////
//// This source is distributed in the hope that it will be      ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied  ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR     ////
//// PURPOSE.  See the GNU Lesser General Public License for more////
//// details. http://www.gnu.org/licenses/lgpl.html              ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:34:52 2011
//--
//-- Source file: dma_core_channels_apb_mux.v
//---------------------------------------------------------



module  dma_axi32_core0_channels_apb_mux (clk,reset,pclken,psel,penable,paddr,prdata,pslverr,ch_psel,ch_prdata,ch_pslverr);

   input                 clk;
   input                 reset;

   input          pclken;
   input          psel;
   input                 penable;
   input [10:8]          paddr;
   output [31:0]         prdata;
   output          pslverr;

   output [7:0]      ch_psel;
   input [32*8-1:0]      ch_prdata;
   input [7:0]          ch_pslverr;

 
   wire [2:0]          paddr_sel;
   reg [2:0]          paddr_sel_d;


   
   always @(posedge clk or posedge reset)
     if (reset)
       paddr_sel_d <= 3'b000;
     else if (psel & (~penable))
       paddr_sel_d <= paddr_sel;
     else if ((~psel) & pclken) //release for empty channels after error
       paddr_sel_d <= 3'b000;
   
   
   
   assign          paddr_sel = paddr[10:8];
   
   prgen_demux8 #(1) mux_psel(
                  .sel(paddr_sel),
                  .x(psel),
                  .ch_x(ch_psel)
                  );

   
   prgen_mux8 #(32) mux_prdata(
                   .sel(paddr_sel_d),
                   
                   .ch_x(ch_prdata),
                   .x(prdata)
                   );


   assign                pslverr = ch_pslverr[paddr_sel_d];
   
endmodule







   


// verilator lint_on WIDTHEXPAND
// verilator lint_on WIDTHTRUNC
