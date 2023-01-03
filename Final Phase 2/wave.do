vsim -gui work.BWZZ_TB

add wave sim:/BWZZ_TB/interrupt
add wave sim:/BWZZ_TB/clk
add wave sim:/BWZZ_TB/reset

add wave sim:/BWZZ_TB/yarb/PC

add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[0]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[1]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[2]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[3]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[4]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[5]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[6]
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers[7]
add wave sim:/BWZZ_TB/yarb/RegisterFile/inport
add wave sim:/BWZZ_TB/yarb/RegisterFile/outport

add wave sim:/BWZZ_TB/yarb/DataMemory/spmManager/sp

add wave sim:/BWZZ_TB/yarb/StatusRegisterBank/CCR


run
force -freeze sim:/BWZZ_TB/yarb/RegisterFile/inport 3'h005 0
run
run
force -freeze sim:/BWZZ_TB/yarb/RegisterFile/inport 3'h019 0
run
force -freeze sim:/BWZZ_TB/yarb/RegisterFile/inport 3'hffff 0
run
force -freeze sim:/BWZZ_TB/yarb/RegisterFile/inport 0'hf320 0
run
