module interruptHandler (
    clk,
    functionBits,
    interruptBit,
    interruptInstruction,
    interruptRaisedToFetch

);
  // I am jump from the decode stage => stall one cycle only
  input interruptBit, clk;
  input [2:0] functionBits;
  output reg interruptRaisedToFetch;
  output reg [15:0] interruptInstruction;

  reg [2:0] nextStateFlag;

  // ? 000 means that I will stall one time
  // ? 001 means that I will stall 2 times then
  // ? 010 means that I will add the first part of the interrupt
  // ? 011 means that I will add the second part of the interrupt
  // ? 100 means that I have executed of the second  of interrupt ,then i will raise interrupt signal to fetch
  initial begin
    nextStateFlag = 3'b000;
    interruptRaisedToFetch = 1'b0;
  end

  // ! check the condition of the always block
  always @(posedge clk) begin

    if (interruptBit == 1'b1) begin

      if (functionBits == 3'b100) begin
        // Need Imm value
        nextStateFlag = 3'b001;

        // Make a bubble
        interruptInstruction = 16'b0000011111111000;

      end

      if (nextStateFlag == 3'b001) begin
        // chnage the state and don't make a bubble
        nextStateFlag = 3'b000;
      end else if (nextStateFlag == 3'b000) begin
        // make a bubble
        interruptInstruction = 16'b0000011111111000;
        nextStateFlag = 3'b010;
      end else if (nextStateFlag == 3'b010) begin
        // first part of the interrupt opCode
        interruptInstruction = 16'b1111010010000000;
        nextStateFlag = 3'b011;
      end else if (nextStateFlag == 3'b011) begin
        // second part of the interrupt opCode
        interruptInstruction = 16'b1111110100000000;
        nextStateFlag = 3'b100;
      end else if (nextStateFlag == 3'b100) begin
        // set interrupt to jump to ivt to execute the interrupt instruction
        interruptRaisedToFetch = 1'b1;
        nextStateFlag = 3'b101;
      end else if (nextStateFlag == 3'b101) begin
        interruptRaisedToFetch = 1'b0;
        nextStateFlag = 3'b000;
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
