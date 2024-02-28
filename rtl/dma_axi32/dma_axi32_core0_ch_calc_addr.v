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
//-- Invoked Fri Mar 25 23:34:53 2011
//--
//-- Source file: dma_ch_calc_addr.v
//---------------------------------------------------------



module dma_axi32_core0_ch_calc_addr(clk,reset,ch_update_d,load_in_prog,load_addr,go_next_line,burst_start,incr,start_addr,frame_width,x_size,burst_size,burst_addr);
   

   input             clk;
   input             reset;
   
   input             ch_update_d;
   input             load_in_prog;
   input [32-1:0]    load_addr;
   
   input             go_next_line;
   input             burst_start;
   input             incr;
   input [32-1:0]    start_addr;
   input [`FRAME_BITS-1:0]  frame_width;
   input [`X_BITS-1:0]         x_size;
   input [7-1:0]   burst_size;
   output [32-1:0]   burst_addr;
   
   
   reg [32-1:0]         burst_addr;
   
   wire             go_next_line_d;
   reg [`FRAME_BITS-1:0]    frame_width_diff_reg;
   wire [`FRAME_BITS-1:0]   frame_width_diff;
   

   
   assign             frame_width_diff = {`FRAME_BITS{1'b0}};
   assign             go_next_line_d   = 1'b0;
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       burst_addr <= {32{1'b0}};
     else if (load_in_prog)
       burst_addr <= load_addr;
     else if (ch_update_d)
       burst_addr <= start_addr;
     else if (burst_start & incr)
       burst_addr <= burst_addr + burst_size;
     else if (go_next_line_d & incr)
       burst_addr <= burst_addr + frame_width_diff;
   
   
endmodule


// verilator lint_on WIDTHEXPAND
// verilator lint_on WIDTHTRUNC
