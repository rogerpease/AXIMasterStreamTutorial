#-----------------------------------------------------------
# Vivado v2021.1 (64-bit)
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
# Start of session at: Sun Dec  5 13:23:11 2021
# Process ID: 400777

set_param board.repoPaths /home/rpease/.Xilinx/Vivado/2022.1/xhub/board_store/xilinx_board_store
get_board_parts
create_project FPGAImageProject ./FPGAImageProject -part xc7z020clg400-1
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
set_property  ip_repo_paths  . [current_project]
update_ip_catalog
create_bd_design "FPGABlockDesign"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
startgroup
create_bd_cell -type ip -vlnv user.org:user:AXIMasterStreamTutorialIP:1.0 AXIMasterStreamTutor_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0} CONFIG.c_include_mm2s {0}] [get_bd_cells axi_dma_0]
startgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells processing_system7_0]
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_dma_0/S_AXI_LITE} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/AXIMasterStreamTutor_0/s00_axi} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins AXIMasterStreamTutor_0/s00_axi]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/axi_dma_0/M_AXI_S2MM} Slave {/processing_system7_0/S_AXI_HP0} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
endgroup
connect_bd_intf_net [get_bd_intf_pins AXIMasterStreamTutor_0/m00_axis] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]
set_property location {3 950 40} [get_bd_cells processing_system7_0]
set_property location {3 950 30} [get_bd_cells processing_system7_0]
set_property location {3 950 20} [get_bd_cells processing_system7_0]
set_property location {3 950 10} [get_bd_cells processing_system7_0]
set_property location {3 950 0} [get_bd_cells processing_system7_0]
set_property location {3 950 -10} [get_bd_cells processing_system7_0]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/processing_system7_0/FCLK_CLK0 (100 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins AXIMasterStreamTutor_0/m00_axis_aclk]
make_wrapper -files [get_files ./FPGAImageProject/FPGAImageProject.srcs/sources_1/bd/FPGABlockDesign/FPGABlockDesign.bd] -top
add_files -norecurse ./FPGAImageProject/FPGAImageProject.gen/sources_1/bd/FPGABlockDesign/hdl/FPGABlockDesign_wrapper.v
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1
open_run impl_1
