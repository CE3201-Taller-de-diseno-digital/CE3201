# TCL File Generated by Component Editor 20.1
# Thu Oct 26 01:42:02 GMT 2023
# DO NOT MODIFY


# 
# gfx "3D graphics accelerator" v1.0
#  2023.10.26.01:42:02
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module gfx
# 
set_module_property DESCRIPTION ""
set_module_property NAME gfx
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "3D graphics accelerator"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL gfx
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file gfx.sv SYSTEM_VERILOG PATH rtl/gfx/gfx.sv TOP_LEVEL_FILE
add_fileset_file fp_add.sv SYSTEM_VERILOG PATH rtl/gfx/fp_add.sv
add_fileset_file fp_mul.sv SYSTEM_VERILOG PATH rtl/gfx/fp_mul.sv
add_fileset_file gfx_defs.sv SYSTEM_VERILOG PATH rtl/gfx/gfx_defs.sv
add_fileset_file horizontal_fold.sv SYSTEM_VERILOG PATH rtl/gfx/horizontal_fold.sv
add_fileset_file mat_mat_mul.sv SYSTEM_VERILOG PATH rtl/gfx/mat_mat_mul.sv
add_fileset_file mat_vec_mul.sv SYSTEM_VERILOG PATH rtl/gfx/mat_vec_mul.sv
add_fileset_file pipeline_flow.sv SYSTEM_VERILOG PATH rtl/gfx/pipeline_flow.sv
add_fileset_file fold_flow.sv SYSTEM_VERILOG PATH rtl/gfx/fold_flow.sv
add_fileset_file skid_flow.sv SYSTEM_VERILOG PATH rtl/gfx/skid_flow.sv
add_fileset_file skid_buf.sv SYSTEM_VERILOG PATH rtl/gfx/skid_buf.sv
add_fileset_file vec_dot.sv SYSTEM_VERILOG PATH rtl/gfx/vec_dot.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point cmd
# 
add_interface cmd avalon end
set_interface_property cmd addressUnits WORDS
set_interface_property cmd associatedClock clock
set_interface_property cmd associatedReset reset_sink
set_interface_property cmd bitsPerSymbol 8
set_interface_property cmd burstOnBurstBoundariesOnly false
set_interface_property cmd burstcountUnits WORDS
set_interface_property cmd explicitAddressSpan 0
set_interface_property cmd holdTime 0
set_interface_property cmd linewrapBursts false
set_interface_property cmd maximumPendingReadTransactions 0
set_interface_property cmd maximumPendingWriteTransactions 0
set_interface_property cmd readLatency 0
set_interface_property cmd readWaitTime 1
set_interface_property cmd setupTime 0
set_interface_property cmd timingUnits Cycles
set_interface_property cmd writeWaitTime 0
set_interface_property cmd ENABLED true
set_interface_property cmd EXPORT_OF ""
set_interface_property cmd PORT_NAME_MAP ""
set_interface_property cmd CMSIS_SVD_VARIABLES ""
set_interface_property cmd SVD_ADDRESS_GROUP ""

add_interface_port cmd cmd_address address Input 6
add_interface_port cmd cmd_read read Input 1
add_interface_port cmd cmd_write write Input 1
add_interface_port cmd cmd_writedata writedata Input 32
add_interface_port cmd cmd_readdata readdata Output 32
set_interface_assignment cmd embeddedsw.configuration.isFlash 0
set_interface_assignment cmd embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment cmd embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment cmd embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink rst_n reset_n Input 1


# 
# connection point mem
# 
add_interface mem avalon start
set_interface_property mem addressUnits SYMBOLS
set_interface_property mem associatedClock clock
set_interface_property mem associatedReset reset_sink
set_interface_property mem bitsPerSymbol 8
set_interface_property mem burstOnBurstBoundariesOnly false
set_interface_property mem burstcountUnits WORDS
set_interface_property mem doStreamReads false
set_interface_property mem doStreamWrites false
set_interface_property mem holdTime 0
set_interface_property mem linewrapBursts false
set_interface_property mem maximumPendingReadTransactions 0
set_interface_property mem maximumPendingWriteTransactions 0
set_interface_property mem readLatency 0
set_interface_property mem readWaitTime 1
set_interface_property mem setupTime 0
set_interface_property mem timingUnits Cycles
set_interface_property mem writeWaitTime 0
set_interface_property mem ENABLED true
set_interface_property mem EXPORT_OF ""
set_interface_property mem PORT_NAME_MAP ""
set_interface_property mem CMSIS_SVD_VARIABLES ""
set_interface_property mem SVD_ADDRESS_GROUP ""

add_interface_port mem mem_address address Output 26
add_interface_port mem mem_read read Output 1
add_interface_port mem mem_write write Output 1
add_interface_port mem mem_readdatavalid readdatavalid Input 1
add_interface_port mem mem_readdata readdata Input 16
add_interface_port mem mem_writedata writedata Output 16
add_interface_port mem mem_waitrequest waitrequest Input 1
