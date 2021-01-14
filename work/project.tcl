set projDir "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/vivado"
set projName "MemoryGameFinal"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/au_top_0.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/reset_conditioner_1.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/button_conditioner_2.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/edge_detector_3.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/gameplay_4.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/pipeline_5.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/sequence_generator_6.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/check_sequence_7.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/multi_seven_seg_8.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/counter_9.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/edge_detector_10.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/counter_11.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/pn_gen_12.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/alu_13.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/counter_14.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/char_coder_15.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/decoder_16.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/adder_17.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/compare_18.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/boolean_19.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/shifter_20.v" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/verilog/multiplier_21.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/constraint/custom.xdc" "C:/Users/Admin/Documents/alchitry/MemoryGameFinal/work/constraint/customio.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
