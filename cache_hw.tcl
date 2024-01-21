# TCL File Generated by Component Editor 20.1
# Wed Oct 04 21:42:03 GMT 2023
# DO NOT MODIFY


# 
# cache "64KiB 1-way cache w/ controller" v1.0
#  2023.10.04.21:42:03
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module cache
# 
set_module_property DESCRIPTION ""
set_module_property NAME cache
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "64KiB 1-way cache w/ controller"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL cache
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file defs.sv SYSTEM_VERILOG PATH rtl/cache/defs.sv
add_fileset_file cache.sv SYSTEM_VERILOG PATH rtl/cache/cache.sv TOP_LEVEL_FILE
add_fileset_file cache_control.sv SYSTEM_VERILOG PATH rtl/cache/cache_control.sv
add_fileset_file cache_token.sv SYSTEM_VERILOG PATH rtl/cache/cache_token.sv
add_fileset_file cache_ring.sv SYSTEM_VERILOG PATH rtl/cache/cache_ring.sv
add_fileset_file cache_mem.sv SYSTEM_VERILOG PATH rtl/cache/cache_mem.sv
add_fileset_file cache_offsets.sv SYSTEM_VERILOG PATH rtl/cache/cache_offsets.sv
add_fileset_file cache_routing.sv SYSTEM_VERILOG PATH rtl/cache/cache_routing.sv
add_fileset_file cache_sram.sv SYSTEM_VERILOG PATH rtl/cache/cache_sram.sv
add_fileset_file cache_monitor.sv SYSTEM_VERILOG PATH rtl/cache/cache_monitor.sv
add_fileset_file cache_debug.sv SYSTEM_VERILOG PATH rtl/cache/cache_debug.sv


# 
# parameters
# 
add_parameter ID INTEGER 0
set_parameter_property ID DEFAULT_VALUE 0
set_parameter_property ID DISPLAY_NAME ID
set_parameter_property ID TYPE INTEGER
set_parameter_property ID UNITS None
set_parameter_property ID ALLOWED_RANGES 0:3
set_parameter_property ID AFFECTS_GENERATION false
set_parameter_property ID HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink rst_n reset_n Input 1


# 
# connection point core
# 
add_interface core avalon end
set_interface_property core addressUnits WORDS
set_interface_property core associatedClock clock_sink
set_interface_property core associatedReset reset_sink
set_interface_property core bitsPerSymbol 8
set_interface_property core burstOnBurstBoundariesOnly false
set_interface_property core burstcountUnits WORDS
set_interface_property core explicitAddressSpan 0
set_interface_property core holdTime 0
set_interface_property core linewrapBursts false
set_interface_property core maximumPendingReadTransactions 0
set_interface_property core maximumPendingWriteTransactions 0
set_interface_property core readLatency 0
set_interface_property core readWaitTime 1
set_interface_property core setupTime 0
set_interface_property core timingUnits Cycles
set_interface_property core writeWaitTime 0
set_interface_property core ENABLED true
set_interface_property core EXPORT_OF ""
set_interface_property core PORT_NAME_MAP ""
set_interface_property core CMSIS_SVD_VARIABLES ""
set_interface_property core SVD_ADDRESS_GROUP ""

add_interface_port core core_address address Input 30
add_interface_port core core_read read Input 1
add_interface_port core core_write write Input 1
add_interface_port core core_waitrequest waitrequest Output 1
add_interface_port core core_readdata readdata Output 32
add_interface_port core core_writedata writedata Input 32
add_interface_port core core_byteenable byteenable Input 4
add_interface_port core core_lock lock Input 1
add_interface_port core core_response response Output 2
set_interface_assignment core embeddedsw.configuration.isFlash 0
set_interface_assignment core embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment core embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment core embeddedsw.configuration.isPrintableDevice 0


# 
# connection point out_data
# 
add_interface out_data avalon_streaming start
set_interface_property out_data associatedClock clock_sink
set_interface_property out_data associatedReset reset_sink
set_interface_property out_data dataBitsPerSymbol 8
set_interface_property out_data errorDescriptor ""
set_interface_property out_data firstSymbolInHighOrderBits true
set_interface_property out_data maxChannel 0
set_interface_property out_data readyLatency 0
set_interface_property out_data ENABLED true
set_interface_property out_data EXPORT_OF ""
set_interface_property out_data PORT_NAME_MAP ""
set_interface_property out_data CMSIS_SVD_VARIABLES ""
set_interface_property out_data SVD_ADDRESS_GROUP ""

add_interface_port out_data out_data_ready ready Input 1
add_interface_port out_data out_data_valid valid Output 1
add_interface_port out_data out_data data Output 160


# 
# connection point in_data
# 
add_interface in_data avalon_streaming end
set_interface_property in_data associatedClock clock_sink
set_interface_property in_data associatedReset reset_sink
set_interface_property in_data dataBitsPerSymbol 8
set_interface_property in_data errorDescriptor ""
set_interface_property in_data firstSymbolInHighOrderBits true
set_interface_property in_data maxChannel 0
set_interface_property in_data readyLatency 0
set_interface_property in_data ENABLED true
set_interface_property in_data EXPORT_OF ""
set_interface_property in_data PORT_NAME_MAP ""
set_interface_property in_data CMSIS_SVD_VARIABLES ""
set_interface_property in_data SVD_ADDRESS_GROUP ""

add_interface_port in_data in_data data Input 160
add_interface_port in_data in_data_ready ready Output 1
add_interface_port in_data in_data_valid valid Input 1


# 
# connection point out_token
# 
add_interface out_token avalon_streaming start
set_interface_property out_token associatedClock clock_sink
set_interface_property out_token associatedReset reset_sink
set_interface_property out_token dataBitsPerSymbol 8
set_interface_property out_token errorDescriptor ""
set_interface_property out_token firstSymbolInHighOrderBits true
set_interface_property out_token maxChannel 0
set_interface_property out_token readyLatency 0
set_interface_property out_token ENABLED true
set_interface_property out_token EXPORT_OF ""
set_interface_property out_token PORT_NAME_MAP ""
set_interface_property out_token CMSIS_SVD_VARIABLES ""
set_interface_property out_token SVD_ADDRESS_GROUP ""

add_interface_port out_token out_token data Output 80
add_interface_port out_token out_token_valid valid Output 1


# 
# connection point in_token
# 
add_interface in_token avalon_streaming end
set_interface_property in_token associatedClock clock_sink
set_interface_property in_token associatedReset reset_sink
set_interface_property in_token dataBitsPerSymbol 8
set_interface_property in_token errorDescriptor ""
set_interface_property in_token firstSymbolInHighOrderBits true
set_interface_property in_token maxChannel 0
set_interface_property in_token readyLatency 0
set_interface_property in_token ENABLED true
set_interface_property in_token EXPORT_OF ""
set_interface_property in_token PORT_NAME_MAP ""
set_interface_property in_token CMSIS_SVD_VARIABLES ""
set_interface_property in_token SVD_ADDRESS_GROUP ""

add_interface_port in_token in_token data Input 80
add_interface_port in_token in_token_valid valid Input 1


# 
# connection point mem
# 
add_interface mem avalon start
set_interface_property mem addressUnits SYMBOLS
set_interface_property mem associatedClock clock_sink
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

add_interface_port mem mem_read read Output 1
add_interface_port mem mem_write write Output 1
add_interface_port mem mem_address address Output 32
add_interface_port mem mem_byteenable byteenable Output 16
add_interface_port mem mem_readdata readdata Input 128
add_interface_port mem mem_writedata writedata Output 128
add_interface_port mem mem_waitrequest waitrequest Input 1


# 
# connection point dbg
# 
add_interface dbg avalon end
set_interface_property dbg addressUnits WORDS
set_interface_property dbg associatedClock clock_sink
set_interface_property dbg associatedReset reset_sink
set_interface_property dbg bitsPerSymbol 8
set_interface_property dbg burstOnBurstBoundariesOnly false
set_interface_property dbg burstcountUnits WORDS
set_interface_property dbg explicitAddressSpan 0
set_interface_property dbg holdTime 0
set_interface_property dbg linewrapBursts false
set_interface_property dbg maximumPendingReadTransactions 0
set_interface_property dbg maximumPendingWriteTransactions 0
set_interface_property dbg readLatency 0
set_interface_property dbg readWaitTime 1
set_interface_property dbg setupTime 0
set_interface_property dbg timingUnits Cycles
set_interface_property dbg writeWaitTime 0
set_interface_property dbg ENABLED true
set_interface_property dbg EXPORT_OF ""
set_interface_property dbg PORT_NAME_MAP ""
set_interface_property dbg CMSIS_SVD_VARIABLES ""
set_interface_property dbg SVD_ADDRESS_GROUP ""

add_interface_port dbg dbg_read read Input 1
add_interface_port dbg dbg_write write Input 1
add_interface_port dbg dbg_address address Input 3
add_interface_port dbg dbg_readdata readdata Output 32
add_interface_port dbg dbg_waitrequest waitrequest Output 1
add_interface_port dbg dbg_writedata writedata Input 32
set_interface_assignment dbg embeddedsw.configuration.isFlash 0
set_interface_assignment dbg embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment dbg embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment dbg embeddedsw.configuration.isPrintableDevice 0

