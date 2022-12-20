restart

add wave sim:/BWZZ_TB/clk
add wave sim:/BWZZ_TB/reset

add wave sim:/BWZZ_TB/yarb/PC
add wave sim:/BWZZ_TB/yarb/NextPC

add wave sim:/BWZZ_TB/yarb/fetchStage/finalInstruction
add wave sim:/BWZZ_TB/yarb/IF_ID_Buffer/oInstruction

add wave sim:/BWZZ_TB/yarb/RegisterFile/*

add wave sim:/BWZZ_TB/yarb/DataMemory/*

add wave sim:/BWZZ_TB/yarb/StatusRegisterBank/CCR

add wave sim:/BWZZ_TB/yarb/BranchSelector/*
add wave sim:/BWZZ_TB/yarb/Forwarding/*
add wave sim:/BWZZ_TB/yarb/MakeMeBubble
add wave sim:/BWZZ_TB/yarb/ControlUnit/*