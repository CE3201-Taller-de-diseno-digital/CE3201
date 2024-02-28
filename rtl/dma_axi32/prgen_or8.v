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
//-- Source file: prgen_or.v
//---------------------------------------------------------


  
module prgen_or8(ch_x,x);

   parameter                  WIDTH      = 8;
   
   
   input [8*WIDTH-1:0]     ch_x;
   output [WIDTH-1:0]           x;
   

   assign x = 
        ch_x[WIDTH-1+WIDTH*0:WIDTH*0] |
        ch_x[WIDTH-1+WIDTH*1:WIDTH*1] |
        ch_x[WIDTH-1+WIDTH*2:WIDTH*2] |
        ch_x[WIDTH-1+WIDTH*3:WIDTH*3] |
        ch_x[WIDTH-1+WIDTH*4:WIDTH*4] |
        ch_x[WIDTH-1+WIDTH*5:WIDTH*5] |
        ch_x[WIDTH-1+WIDTH*6:WIDTH*6] |
        ch_x[WIDTH-1+WIDTH*7:WIDTH*7] ;
   
endmodule
   


// verilator lint_on WIDTHEXPAND
// verilator lint_on WIDTHTRUNC
