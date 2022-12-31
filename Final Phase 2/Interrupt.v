module interruptHandler (
    clk,
    functionBits,
    interruptBit,
    interruptInstruction,
    interruptRaisedToFetch,
    interruptRaisedInstruction,
    nextPC,
    interruptPC,
    interruptRaisedPC,
    iamJMP
);
  // I am jump from the decode stage => stall one cycle only
  input interruptBit, clk, iamJMP;
  input [2:0] functionBits;
  input [31:0] nextPC;
  output reg interruptRaisedToFetch,interruptRaisedInstruction,interruptRaisedPC;
  output reg [15:0] interruptInstruction;
  output reg [31:0] interruptPC;

  reg [2:0] nextStateFlag;

  reg [31:0] savedPc;

  reg functionBitsFlag;
  reg startWork, myIamJmpFlag;
  reg [2:0] myFunctionBits;


  // ? 000 means that I am ready          0
  // ? 001 means that I will stall 2 times then           1
  // ? 110 means that  I will stall one time             6
  // ? 010 means that I will add the first part of the interrupt      2
  // ? 011 means that I will add the second part of the interrupt       3
  // ? 100 means that I have executed of the second  of interrupt ,then i will raise interrupt signal to fetch      4
  // ? 101 means that I will make interruptRaisedToFetch zero again and make the state back to the first state      5
  // ? 111 means that I'm a jmp instruction so I will wait one cycle so the pc is calculated then save the pc

  initial begin
    nextStateFlag = 3'b000;
    interruptRaisedToFetch = 1'b0;
    startWork = 1'b0;
    interruptRaisedInstruction = 1'b0;
    interruptRaisedPC = 1'b0;
  end

always @(posedge interruptBit) begin
  startWork = 1'b1;
  functionBitsFlag = 1'b1;
  // myFunctionBits = functionBits;
  
end

  // ! check the condition of the always block
  always @(posedge clk) begin
    if(functionBitsFlag == 1'b1) begin
      #2
      myFunctionBits = functionBits;
      functionBitsFlag = 1'b0;
      savedPc = nextPC;
      myIamJmpFlag = iamJMP;
    end

    if (startWork == 1'b1) begin
      

      if(myIamJmpFlag == 1'b1 && nextStateFlag == 3'b000)begin
        nextStateFlag = 3'b111;
        interruptRaisedInstruction = 1'b0;
        
      end
      else begin
        interruptRaisedInstruction = 1'b1;
      end

      if (myFunctionBits == 3'b100 && nextStateFlag==3'b000) begin
        // Need Imm value
        nextStateFlag = 3'b001;
        savedPc = nextPC + 1'b1;
        // Make a bubble
        interruptInstruction = 16'b0000011111111000;
      end else if(myFunctionBits != 3'b100 && nextStateFlag==3'b000) begin
        nextStateFlag = 3'b110;
      end

      if(nextStateFlag == 3'b111) begin
        // i'm a jmp instruction
        nextStateFlag = 3'b010;
      end
      else if (nextStateFlag == 3'b001) begin
        // chnage the state and don't make a bubble
        nextStateFlag = 3'b110;
      end else if (nextStateFlag == 3'b110) begin
        // make a bubble
        interruptInstruction = 16'b0000011111111000;
        nextStateFlag = 3'b010;
      end else if(nextStateFlag == 3'b010 && myIamJmpFlag == 1'b1 )begin
        #1
        savedPc = nextPC - 1'b1;
        interruptRaisedInstruction = 1'b1;
        // first part of the interrupt opCode
        interruptInstruction = 16'b1111010010000000;
        interruptRaisedPC = 1'b1;
        interruptPC = savedPc;
        nextStateFlag = 3'b011;
      end
      else if (nextStateFlag == 3'b010) begin
        // first part of the interrupt opCode
        interruptInstruction = 16'b1111010010000000;
        interruptRaisedPC = 1'b1;
        interruptPC = savedPc;
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
        startWork = 1'b0;
        interruptRaisedInstruction = 1'b0;
        interruptRaisedPC = 1'b0;
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