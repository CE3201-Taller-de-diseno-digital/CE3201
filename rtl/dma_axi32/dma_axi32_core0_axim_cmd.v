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
//-- Source file: dma_core_axim_cmd.v
//---------------------------------------------------------



module dma_axi32_core0_axim_cmd(clk,reset,ch_num,burst_start,burst_addr,burst_size,end_line_cmd,extra_bit,cmd_port,joint_req,joint_pending,cmd_pending,cmd_full,cmd_split,cmd_num,cmd_line,page_cross,AID,AADDR,APORT,ALEN,ASIZE,AVALID,AREADY,AWVALID,AJOINT,axim_timeout_num,axim_timeout);

   parameter                  AXI_WORD_SIZE = 1 ? 2'b10 : 2'b11;
   parameter                  AXI_2 = 1 ? 2 : 3;

   input               clk;
   input               reset;
   
   input [2:0]               ch_num;
   
   input               burst_start;
   input [32-1:0]      burst_addr;
   input [7-1:0]     burst_size;
   input               end_line_cmd;
   input               extra_bit;
   input               cmd_port;
   input               joint_req;
   
   output               joint_pending;
   output               cmd_pending;
   input               cmd_full;
   output               cmd_split;
   output [2:0]           cmd_num;
   output               cmd_line;
   
   output               page_cross;
   
   output [`CMD_BITS-1:0]     AID;
   output [32-1:0]     AADDR;
   output               APORT;
   output [`LEN_BITS-1:0]     ALEN;
   output [1:0]           ASIZE;
   output               AVALID;
   input               AREADY;
   input               AWVALID;
   output               AJOINT;
   
   output [2:0]           axim_timeout_num;
   output               axim_timeout;
   

   
   reg [`CMD_BITS-1:0]           AID;
   reg [`CMD_BITS-1:0]           AID_reg;
   reg [32-1:0]           AADDR;
   reg                   APORT;
   reg [`LEN_BITS-1:0]           ALEN;
   reg [1:0]               ASIZE;
   reg                   AVALID_reg;
   reg                   AJOINT;
   

   wire [`CMD_BITS-1:0]       AID_pre;
   wire [32-1:0]       AADDR_pre;
   wire [1:0]               ASIZE_pre;
   wire [`LEN_BITS-1:0]       ALEN_pre;
   wire [7-1:0]      burst_length;

   wire               cmd;
   reg                   cmd_pending;
   wire               cmd_line_pre;
   wire               cmd_line;

   wire               high_addr_pre;
   wire               high_addr;
   wire [8:0]               burst_reach_pre;
   reg [8:0]               burst_reach;
   reg                   joint_cross;
   wire               page_cross_pre;
   wire               page_cross;
   wire               cross_start;
   wire               cross_start_d;
   wire [8:0]               max_burst;
   reg [8:0]               max_burst_d;
   reg                   next_burst;
   reg [7-1:0]       next_burst_size;
   wire               next_burst_start;
      


   
   assign               high_addr_pre    = burst_addr[11:8] == 4'hf;
   assign               burst_reach_pre  = burst_addr[7:0] + burst_size;
   assign               page_cross       = high_addr & (burst_reach > {1'b1, {8{1'b0}}});
   assign               max_burst        = {1'b1, {8{1'b0}}} - burst_addr[7:0];
   assign               next_burst_start = next_burst & (~AVALID_reg) & (~cmd_full);
   assign               cross_start      = burst_start & page_cross;

   
   prgen_delay #(1) delay_high_addr (.clk(clk), .reset(reset), .din(high_addr_pre), .dout(high_addr));
   prgen_delay #(1) delay_cross_start (.clk(clk), .reset(reset), .din(cross_start), .dout(cross_start_d));
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       burst_reach <= {9{1'b0}};
     else if (high_addr_pre)
       burst_reach <= burst_reach_pre;
   
   always @(posedge clk or posedge reset)
     if (reset)
       next_burst <= 1'b0;
     else if (next_burst_start)
       next_burst <= 1'b0;
     else if (cross_start)
       next_burst <= 1'b1;
          
   always @(posedge clk or posedge reset)
     if (reset)
       max_burst_d <= {9{1'b0}};
     else if (cross_start)
       max_burst_d <= max_burst;
   
   always @(posedge clk or posedge reset)
     if (reset)
       next_burst_size <= {7{1'b0}};
     else if (cross_start)
       next_burst_size <= burst_size;
     else if (cross_start_d)
       next_burst_size <= next_burst_size - max_burst_d;
   
   assign               cmd_split       = cross_start_d;
   
   assign               cmd             = AVALID & AREADY;
   assign               cmd_num         = AID[2:0];
   assign               cmd_line_pre    = cmd & AID[6];              

   assign               joint_pending   = AVALID & (~AREADY) & AJOINT;
   
   always @(posedge clk or posedge reset)
     if (reset)
       cmd_pending <= 1'b0;
     else if (burst_start)
       cmd_pending <= 1'b1;
     else if (cmd & (~next_burst))
       cmd_pending <= 1'b0;
   
   
   prgen_delay #(1) delay_cmd_line (.clk(clk), .reset(reset), .din(cmd_line_pre), .dout(cmd_line));
   
   assign               AID_pre = {
                     end_line_cmd,   //[6]
                     ASIZE_pre[1:0], //[5:4]
                     extra_bit,      //[3]
                     ch_num[2:0]     //[2:0]
                     };

   assign               AADDR_pre = burst_addr;
   
   assign               ASIZE_pre = 
                  burst_size == 'd1 ? 2'b00 :
                  burst_size == 'd2 ? 2'b01 :
                  burst_size == 'd4 ? 2'b10 : 
                  AXI_WORD_SIZE;
   
   assign               burst_length =
                  next_burst    ? next_burst_size :
                  page_cross    ? max_burst       : burst_size;
   
   assign               ALEN_pre =
                  burst_length[7-1:AXI_2] == 'd0 ? {`LEN_BITS{1'b0}} :
                  burst_length[7-1:AXI_2] - 1'b1;
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      ASIZE  <= {2{1'b0}};
      AJOINT <= 1'b0;
       end
     else if (burst_start)
       begin
      ASIZE  <= ASIZE_pre;
      AJOINT <= joint_req;
       end

   always @(posedge clk or posedge reset)
     if (reset)
       AID_reg <= {`CMD_BITS{1'b0}};
     else if (burst_start)
       AID_reg <= AID_pre;

   always @(AID_reg or next_burst)
     begin
    AID               = AID_reg;
    AID[`ID_END_LINE] = AID_reg[`ID_END_LINE] & (~next_burst);
    AID[`ID_LAST]     = AID_reg[`ID_LAST] & (~next_burst);
     end
   
   always @(posedge clk or posedge reset)
     if (reset)
       AADDR  <= {32{1'b0}};
     else if (next_burst_start)
       AADDR  <= {AADDR[32-1:12], {12{1'b1}}} + 1'b1;
     else if (burst_start)
       AADDR  <= AADDR_pre;

   always @(posedge clk or posedge reset)
     if (reset)
       APORT <= 1'b0;
     else if (burst_start)
       APORT <= cmd_port;
   
   always @(posedge clk or posedge reset)
     if (reset)
       ALEN   <= {`LEN_BITS{1'b0}};
     else if (burst_start | next_burst_start)
       ALEN   <= ALEN_pre;

   always @(posedge clk or posedge reset)
     if (reset)
       AVALID_reg <= 1'b0;
     else if (AVALID & AREADY)
       AVALID_reg <= 1'b0;
     else if ((burst_start & (burst_size > 'd0)) | next_burst_start)
       AVALID_reg <= 1'b1;

   assign AVALID = AJOINT ? AVALID_reg & (~AWVALID) : AVALID_reg;
   
   dma_axi32_core0_axim_timeout  dma_axi32_axim_timeout (
                         .clk(clk),
                         .reset(reset),
                         .VALID(AVALID),
                         .READY(AREADY),
                         .ID(AID),
                         .axim_timeout_num(axim_timeout_num),
                         .axim_timeout(axim_timeout)
                         );
   
   
endmodule





// verilator lint_on WIDTHEXPAND
// verilator lint_on WIDTHTRUNC
