module interruptHandler (
    clk,
    functionBits,
    opCode,
    interruptBit,
    interruptInstruction,
    interruptRaisedToFetch,
    interruptRaisedInstruction,
    iamJMP,
    interruptIamBubble,
    interruptRaisedBubble,
    interruptStall
);


  // I am jump from the decode stage => stall one cycle only
  input interruptBit, clk, iamJMP;
  input [2:0] functionBits;
  input [4:0] opCode;
  output reg interruptRaisedToFetch,interruptRaisedInstruction,interruptIamBubble,interruptRaisedBubble,interruptStall;
  output reg [15:0] interruptInstruction;

  reg [2:0] nextStateFlag;


  reg startReadFlags;
  reg startWork, myIamJmpFlag;
  reg [2:0] myFunctionBits;
  reg [4:0] myOpCode;


  // ? 000 means that I am ready          0
  // ? 001 means that I will stall 2 times then           1
  // ? 110 means that  I will stall one time             6
  // ? 010 means that I will add the first part of the interrupt      2
  // ? 011 means that I will add the second part of the interrupt       3
  // ? 100 means that I have executed of the second  of interrupt ,then i will raise interrupt signal to fetch      4
  // ? 101 means that I will make interruptRaisedToFetch zero again and make the state back to the first state      5
  // ? 111 means that I will pass the next intruction as it is the second half of the last incturction then go to the normal state of the interrupt 


  initial begin
    nextStateFlag = 3'b000;
    interruptRaisedToFetch = 1'b0;
    startWork = 1'b0;
    interruptRaisedInstruction = 1'b0;
    interruptRaisedBubble = 1'b0;
    interruptStall = 1'b0;
  end

always @(posedge interruptBit) begin
  startWork = 1'b1;
  startReadFlags = 1'b1;
  myFunctionBits = functionBits;
  myOpCode = opCode;
end

  always @(posedge clk) begin
    if(startReadFlags == 1'b1) begin
      #2
      // myFunctionBits = functionBits;
      // myOpCode = opCode;
      startReadFlags = 1'b0;
      // savedPc = nextPC;
      myIamJmpFlag = iamJMP;

    if((myOpCode == 5'b11001 || myOpCode == 5'b11011 || myOpCode == 5'b10111|| myOpCode == 5'b10110 || myOpCode == 5'b10101 || myOpCode == 5'b10100) 
    && nextStateFlag == 3'b000)begin
        // second part of call or ret or any type of jmp
        // Stall 2 cycles out bubble and don't change pc
        nextStateFlag = 3'b001;
      end
      else if(myFunctionBits == 3'b100 || myOpCode == 5'b11000 || myOpCode == 5'b11010)begin
        // the instruction have another half
        // pass the second part of the instruction
        nextStateFlag = 3'b111;

      end else begin
        // normal case 
        // check the instruction in the decode stage if it is a jump instruction
        // wait till it enters the ALU (stall one cycle)
        if(myIamJmpFlag == 1'b1)begin
          // go the the state where i will stall one cycle
          nextStateFlag = 3'b110;
        end else begin
          // go the the state where i will add the first part of the interrupt
          nextStateFlag = 3'b010;
        end
      end
    end


    if (startWork == 1'b1) begin
      interruptStall = 1'b1;
      if(nextStateFlag == 3'b001) begin
        // stall 2 cycles
        interruptIamBubble=1'b1;
        interruptRaisedBubble=1'b1;
        interruptRaisedInstruction = 1'b1;
        interruptInstruction = 16'b0000011111111000;
        nextStateFlag = 3'b110;
      end else if(nextStateFlag == 3'b110)begin
        // stall 1 cycles
        interruptIamBubble=1'b1;
        interruptRaisedBubble=1'b1;
        interruptRaisedInstruction = 1'b1;
        interruptInstruction = 16'b0000011111111000;
        nextStateFlag = 3'b010;

      end else if(nextStateFlag == 3'b010)begin
        // start interrupt work
        // first part of the interrupt opCode
        interruptIamBubble=1'b0;
        interruptRaisedBubble=1'b0;
        interruptRaisedInstruction = 1'b1;
        interruptInstruction = 16'b1111010010000000;
        nextStateFlag = 3'b011;

      end else if(nextStateFlag == 3'b011) begin
        // second part of the interrupt opCode
        interruptRaisedInstruction = 1'b1;
        interruptInstruction = 16'b1111110100000000;
        nextStateFlag = 3'b100;
      end else if(nextStateFlag == 3'b100) begin
        // set interrupt to jump to ivt to execute the interrupt instruction
        interruptRaisedToFetch = 1'b1;
        interruptRaisedInstruction = 1'b0;
        interruptStall= 1'b0;
        nextStateFlag = 3'b101;
      end else if (nextStateFlag == 3'b101) begin
        interruptRaisedToFetch = 1'b0;
        nextStateFlag = 3'b000;
        startWork = 1'b0;
        interruptStall = 1'b0;
        interruptIamBubble = 1'b0;
        interruptRaisedInstruction = 1'b0;
        interruptRaisedBubble = 1'b0;
        myIamJmpFlag=1'b0;
      end else if(nextStateFlag == 3'b111) begin
        // I will do nothing(pass the next instruction) then go the the first state to check it's case 
        // change the start read flags to repeat the whole interrupt scenario
        startReadFlags = 1'b1;
        nextStateFlag = 3'b000;
        interruptStall = 1'b0;
        myFunctionBits = functionBits;
        myOpCode = opCode;
      end
    end
  end

endmodule