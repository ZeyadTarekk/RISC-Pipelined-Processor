#compile
vlog Execute.v

#simulate
vsim ExecuteStage
add wave *

force reset 1
force updateStatus 1
run

force reset 0

#ADD
force ALUControl 0000
force RegSrc 0000000000001111
force RegDst 0000000000001111
run

force RegSrc 1000000000001111
force RegDst 1000000000001111
run

#SUB
force ALUControl 0001
force RegSrc 0000000000000000
force RegDst 0000000000001111
run

#AND
force ALUControl 0010
force RegSrc 0000000000001111
force RegDst 0000000000001111
run

#SHL
force ALUControl 0100
force RegSrc 0000000000001111
force immediate 0000000000000011
run

#SHR
force ALUControl 0101
force RegSrc 0000000000001111
force immediate 0000000000000011
run

#NOT
force ALUControl 0110
force RegSrc 0000000000001111
run

#PASS First
force ALUControl 1010
run

#PASS Second
force ALUControl 0111
run

#INC
force ALUControl 1000
run

#DEC
force ALUControl 1001
run