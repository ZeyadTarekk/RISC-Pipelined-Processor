vsim -gui work.BWZZ_TB

add wave sim:/BWZZ_TB/interrupt
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptRaisedToFetch
add wave sim:/BWZZ_TB/clk
add wave sim:/BWZZ_TB/reset
add wave sim:/BWZZ_TB/yarb/interruptHandler/functionBits
add wave sim:/BWZZ_TB/yarb/interruptHandler/myFunctionBits
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptRaisedInstruction
add wave sim:/BWZZ_TB/yarb/interruptHandler/startWork
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptBit
add wave sim:/BWZZ_TB/yarb/interruptHandler/nextPC
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptPC
add wave sim:/BWZZ_TB/yarb/SELECTED_NEXT_PC
add wave sim:/BWZZ_TB/yarb/interruptHandler/savedPc
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptRaisedPC
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptInstruction
add wave sim:/BWZZ_TB/yarb/interruptHandler/nextStateFlag
add wave sim:/BWZZ_TB/yarb/SELECTED_INSTRUCTION

add wave sim:/BWZZ_TB/yarb/PC
add wave sim:/BWZZ_TB/yarb/fetchStage/finalInstruction
add wave sim:/BWZZ_TB/yarb/IF_ID_Buffer/oInstruction

add wave sim:/BWZZ_TB/yarb/ALUStage/*


add wave sim:/BWZZ_TB/yarb/RegisterFile/*

add wave sim:/BWZZ_TB/yarb/DataMemory/*

add wave sim:/BWZZ_TB/yarb/StatusRegisterBank/CCR

add wave sim:/BWZZ_TB/yarb/BranchSelector/*
add wave sim:/BWZZ_TB/yarb/Forwarding/*
add wave sim:/BWZZ_TB/yarb/MakeMeBubble
add wave sim:/BWZZ_TB/yarb/ControlUnit/*
add wave sim:/BWZZ_TB/yarb/WriteBackStage/*
add wave sim:/BWZZ_TB/yarb/fetchStage/iRImemediate/*
add wave sim:/BWZZ_TB/yarb/*