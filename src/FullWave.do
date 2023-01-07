vsim -gui work.BWZZ_TB

add wave sim:/BWZZ_TB/yarb/flushRet/state
add wave sim:/BWZZ_TB/yarb/flushRet/flushSignal
add wave sim:/BWZZ_TB/interrupt
add wave sim:/BWZZ_TB/yarb/interruptHandler/interruptRaisedToFetch
add wave sim:/BWZZ_TB/clk
add wave sim:/BWZZ_TB/reset
add wave sim:/BWZZ_TB/yarb/DataMemory/spmManager/sp
add wave sim:/BWZZ_TB/yarb/PC
add wave sim:/BWZZ_TB/yarb/fetchStage/finalInstruction
add wave sim:/BWZZ_TB/yarb/IF_ID_Buffer/oInstruction
add wave sim:/BWZZ_TB/yarb/iamJMP
add wave sim:/BWZZ_TB/yarb/SELECTED_INSTRUCTION

add wave sim:/BWZZ_TB/yarb/ALUStage/*
add wave sim:/BWZZ_TB/yarb/*
add wave sim:/BWZZ_TB/yarb/interruptHandler/*


add wave sim:/BWZZ_TB/yarb/RegisterFile/*

add wave sim:/BWZZ_TB/yarb/DataMemory/*

add wave sim:/BWZZ_TB/yarb/StatusRegisterBank/CCR

add wave sim:/BWZZ_TB/yarb/BranchSelector/*
add wave sim:/BWZZ_TB/yarb/Forwarding/*
add wave sim:/BWZZ_TB/yarb/MakeMeBubble
add wave sim:/BWZZ_TB/yarb/ControlUnit/*
add wave sim:/BWZZ_TB/yarb/WriteBackStage/*
add wave sim:/BWZZ_TB/yarb/fetchStage/iRImemediate/*

add wave sim:/BWZZ_TB/yarb/RegisterFile/*
add wave sim:/BWZZ_TB/yarb/RegisterFile/registers

add wave sim:/BWZZ_TB/yarb/DataMemory/spmManager/*

add wave sim:/BWZZ_TB/yarb/fetchStage/*