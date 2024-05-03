cores := gfx_shader_schedif

define core
  $(this)/deps := axixbar fp_unit gfx_shader_schedif picorv32

  $(this)/rtl_top := gfx_top
  $(this)/rtl_dirs := .
  $(this)/rtl_files := gfx_isa.sv gfx_pkg.sv gfx_top.sv

  $(this)/vl_main := main.cpp
  $(this)/vl_pkgconfig := sdl2
endef

define core/gfx_shader_schedif
  $(this)/hooks := regblock

  $(this)/regblock_rdl := gfx_shader_schedif.rdl
  $(this)/regblock_top := gfx_shader_schedif
  $(this)/regblock_args := --default-reset arst_n
  $(this)/regblock_cpuif := axi4-lite
endef
