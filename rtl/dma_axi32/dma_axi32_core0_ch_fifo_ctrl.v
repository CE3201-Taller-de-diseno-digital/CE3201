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
//-- Invoked Fri Mar 25 23:34:54 2011
//--
//-- Source file: dma_ch_fifo_ctrl.v
//---------------------------------------------------------


  
module dma_axi32_core0_ch_fifo_ctrl (clk,reset,end_swap,joint_in_prog,wr_outstanding,ch_update,fifo_wr,fifo_wdata,fifo_wsize,wr_align,rd_incr,fifo_rd,fifo_rsize,rd_align,wr_incr,wr_single,wr_burst_size,rd_clr_line,wr_clr_line,wr_next_size,fifo_rd_valid,fifo_rdata,fifo_wr_ready,fifo_overflow,fifo_underflow);

   input               clk;
   input               reset;
   
   input [1:0]               end_swap;
   
   input               joint_in_prog;
   input               wr_outstanding;
   input               ch_update;

   input               fifo_wr;
   input [32-1:0]      fifo_wdata;
   input [3-1:0]      fifo_wsize;
   input [2-1:0]      wr_align;
   input               rd_incr;
   
   input               fifo_rd;
   input [3-1:0]      fifo_rsize;
   input [2-1:0]      rd_align;
   input               wr_incr;
   input               wr_single;
   input [7-1:0]     wr_burst_size;

   input               rd_clr_line;
   input               wr_clr_line;
   input [3-1:0]      wr_next_size;

   output               fifo_rd_valid;
   output [32-1:0]     fifo_rdata;
   output               fifo_wr_ready;
   output               fifo_overflow;
   output               fifo_underflow;
   

   
   //outputs of wr slicer
   wire               slice_wr;
   wire               slice_wr_fifo;
   wire [5-1:0]       slice_wr_ptr;
   wire [4-1:0]       slice_bsel;
   wire [32-1:0]       slice_wdata;
   wire [3-1:0]       slice_wsize;

   //outputs of rd slicer
   wire               slice_rd;
   wire [32-1:0]       slice_rdata;
   wire [3-1:0]       slice_rsize;
   wire [5-1:0]       slice_rd_ptr;
   wire               slice_rd_valid;

   //outputs of fifo ptr
   wire [5-1:0]       rd_ptr;
   wire [5-1:0]       wr_ptr;
   wire [3-1:0]       rd_line_remain;
   wire               joint_delay;
   wire               fifo_wr_ready;
   wire               fifo_overflow;
   wire               fifo_underflow;
   
   //outputs of fifo
   wire [32-1:0]       DOUT;

   wire               fifo_wr_d;
   reg [32-1:0]           fifo_wdata_d;
   wire               fifo_wr_valid;
   wire [32-1:0]       fifo_wdata_valid;
   

   assign               fifo_wr_valid    = fifo_wr;
   assign               fifo_wdata_valid = fifo_wdata;

   
   assign               fifo_rdata    = slice_rdata & {32{slice_rd_valid}};
   assign               fifo_rd_valid = slice_rd_valid;

   
   dma_axi32_core0_ch_wr_slicer
   dma_axi32_ch_wr_slicer (
            .clk(clk),
            .reset(reset),
            .ch_update(ch_update),
            .rd_clr_line(rd_clr_line),
            .fifo_wr(fifo_wr_valid),
            .fifo_wdata(fifo_wdata_valid),
            .fifo_wsize(fifo_wsize),
            .wr_align(wr_align),
            .wr_ptr(wr_ptr),
            .rd_incr(rd_incr),
            .end_swap(end_swap),
            .slice_wr(slice_wr),
            .slice_wr_fifo(slice_wr_fifo),
            .slice_wr_ptr(slice_wr_ptr),
            .slice_bsel(slice_bsel),
            .slice_wdata(slice_wdata),
            .slice_wsize(slice_wsize)
            );
   
   
   dma_axi32_core0_ch_rd_slicer
   dma_axi32_ch_rd_slicer (
            .clk(clk),
            .reset(reset),
            .fifo_rd(fifo_rd),
            .fifo_rdata(DOUT),
            .fifo_rsize(fifo_rsize),
            .rd_align(rd_align),
            .rd_ptr(rd_ptr),
            .rd_line_remain(rd_line_remain),
            .wr_incr(wr_incr),
            .wr_single(wr_single),
            .slice_rd(slice_rd),
            .slice_rdata(slice_rdata),
            .slice_rd_valid(slice_rd_valid),
            .slice_rsize(slice_rsize),
            .slice_rd_ptr(slice_rd_ptr)
            );
   
   
   dma_axi32_core0_ch_fifo_ptr
   dma_axi32_ch_fifo_ptr (
               .clk(clk),
               .reset(reset),
               .joint_in_prog(joint_in_prog),
               .wr_outstanding(wr_outstanding),
               .ch_update(ch_update),
               .fifo_rd(fifo_rd),
               .fifo_rsize(fifo_rsize),
               .slice_wr(slice_wr),
               .slice_wr_fifo(slice_wr_fifo),
               .slice_wsize(slice_wsize),
               .slice_rd(slice_rd),
               .slice_rsize(slice_rsize),
               .rd_clr_line(rd_clr_line),
               .wr_clr_line(wr_clr_line),
               .rd_ptr(rd_ptr),
               .wr_ptr(wr_ptr),
               .rd_line_remain(rd_line_remain),
               .joint_delay(joint_delay),
               .wr_next_size(wr_next_size),
               .wr_burst_size(wr_burst_size),
               .fifo_wr_ready(fifo_wr_ready),
               .fifo_overflow(fifo_overflow),
               .fifo_underflow(fifo_underflow)
               );

   
   dma_axi32_core0_ch_fifo
   dma_axi32_ch_fifo (
           .CLK(clk),
           .WR(slice_wr_fifo),
           .RD(slice_rd),
           .WR_ADDR(slice_wr_ptr[5-1:2] ),
           .RD_ADDR(slice_rd_ptr[5-1:2]),
           .DIN(slice_wdata),
           .BSEL(slice_bsel),
           .DOUT(DOUT)
           );

   
endmodule






// verilator lint_on WIDTHEXPAND
// verilator lint_on WIDTHTRUNC
