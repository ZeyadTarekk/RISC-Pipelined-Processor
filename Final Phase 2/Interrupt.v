module interruptHandler (clk,functionBits ,interruptBit, interruptInstruction);
// I am jump from the decode stage => stall one cycle only
input interruptBit, clk;
input [2:0] functionBits;
output reg [15:0] interruptInstruction;


reg [1:0] nextStateFlag;

// ? 00 means that I will stall one time
// ? 01 means that I will stall 2 times then
// ? 10 means that I will add the first part of the interrupt
// ? 11 means that I will add the second part of the interrupt
initial begin
nextStateFlag = 2'b00;

end

// ! check the condition of the always block
always @(posedge clk) begin

  if(interruptBit == 1'b1)begin

    if(functionBits == 3'b100) begin
      // Need Imm value
      nextStateFlag = 2'b01;

      // Make a bubble
      interruptInstruction = 16'b0000011111111000;

    end

    if(nextStateFlag == 2'b01) begin 
      // chnage the state and don't make a bubble
      nextStateFlag = 2'b00;
    end else if(nextStateFlag == 2'b00) begin
      // make a bubble
      interruptInstruction = 16'b0000011111111000;
      nextStateFlag = 2'b10;
    end else if(nextStateFlag == 2'b10) begin
      // first part of the interrupt opCode
      interruptInstruction = 16'b1111010010000000;
      nextStateFlag = 2'b11;
    end else if(nextStateFlag == 2'b11) begin 
      // second part of the interrupt opCode
      interruptInstruction = 16'b1111110100000000;
      nextStateFlag = 2'b00;
    end


  end


end

// check if the current opCode in the fetch stage is jump => stall two cycles (the instructsion reach the alu stage to determine the right address to jump)

// if iamJMP 1 , then raise the stall flag

// first normal case 
// MUL R1,R3 then ADD R2,R4




// second case
// LDM R1,5 then ADD R2,R4


endmodule