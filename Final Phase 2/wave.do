restart

add wave sim:/BWZZ_TB/clk
add wave sim:/BWZZ_TB/yarb/PC
add wave sim:/BWZZ_TB/yarb/NextPC

add wave sim:/BWZZ_TB/reset
add wave sim:/BWZZ_TB/yarb/fetchStage/finalInstruction
add wave sim:/BWZZ_TB/yarb/IF_ID_Buffer/oInstruction

add wave sim:/BWZZ_TB/yarb/ALUStage/Operand1
add wave sim:/BWZZ_TB/yarb/ALUStage/Operand2
add wave sim:/BWZZ_TB/yarb/detectHazard/MakeMeBubble

add wave sim:/BWZZ_TB/yarb/MEM_WB_Buffer/oRegWrite
add wave sim:/BWZZ_TB/yarb/MEM_WB_Buffer/oMemOrReg
add wave sim:/BWZZ_TB/yarb/MEM_WB_Buffer/oRegDestAddress
add wave sim:/BWZZ_TB/yarb/MEM_WB_Buffer/oDataRes
add wave sim:/BWZZ_TB/yarb/MEM_WB_Buffer/oData

add wave sim:/BWZZ_TB/yarb/WriteBackStage/memData
add wave sim:/BWZZ_TB/yarb/WriteBackStage/aluData
add wave sim:/BWZZ_TB/yarb/WriteBackStage/outputRes

add wave sim:/BWZZ_TB/yarb/StatusRegisterBank/CCR
add wave sim:/BWZZ_TB/yarb/StatusRegisterBank/carryFlag
