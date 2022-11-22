module DMTESTBENCH();

reg clk,rst;
reg MemRead , MemWrite , SPOrALUres;
reg [1:0] SPOpeartion;
reg [15:0] RegSrc , Data_result;

// output
wire [15:0] Data;

MemoryStage ourmemo( .MemRead(MemRead) , .MemWrite(MemWrite), .SPOrALUres(SPOrALUres), .clk(clk), .rst(rst) , .SPOpeartion(SPOpeartion), .RegSrc(RegSrc), .Data_result(Data_result), .Data(Data));


initial
	begin 	
		clk=1;
		MemRead=0;
		SPOpeartion=00;
		MemWrite=0;
		SPOrALUres=0;
		RegSrc=0;
		Data_result=0;
		rst=1;
$display("MemRead=%b , MemWrite=%b  , SPOrALUres=%b   , SPOpeartion=%b  , RegSrc=%b , Data_result=%b , Data=%b", MemRead, MemWrite, SPOrALUres, SPOpeartion, RegSrc,Data_result , Data );
	end
always #10 clk=!clk;
initial
begin
#20
		// write 4  to location 2
		MemRead=0;
		MemWrite=1;
		SPOrALUres=1;
		SPOpeartion=00;	
		RegSrc=4;
		Data_result=2;
		rst=0;

#20
		// read location 2
		MemRead=1;
		MemWrite=0;
		SPOrALUres=1;
		SPOpeartion=00;	
		RegSrc=0;
		Data_result=2;

#20
		// write 12 to location 2
		MemRead=0;
		MemWrite=1;
		SPOrALUres=1;
		SPOpeartion=00;	
		RegSrc=12;
		Data_result=2;

#20
		// read from location 2
		MemRead=1;
		MemWrite=0;
		SPOrALUres=1;
		SPOpeartion=00;	
		RegSrc=0;
		Data_result=2;

#20
		// write 4 to locatio 8
		MemRead=0;
		MemWrite=1;
		SPOrALUres=1;
		SPOpeartion=00;	
		RegSrc=4;
		Data_result=8;

#20
		//read location 8
		MemRead=1;
		MemWrite=0;
		SPOrALUres=1;
		SPOpeartion=00;	
		RegSrc=0;
		Data_result=8;

#20
		// push 16
		MemRead=0;
		MemWrite=1;
		SPOrALUres=0;
		SPOpeartion=01;	
		RegSrc=16;
		Data_result=0;

#20
		// pop
		MemRead=1;
		MemWrite=0;
		SPOrALUres=0;
		SPOpeartion=10;	
		RegSrc=0;
		Data_result=0;


#20
		// push 18
		MemRead=0;
		MemWrite=1;
		SPOrALUres=0;
		SPOpeartion=01;	
		RegSrc=18;
		Data_result=0;

#20
		// push 2
		MemRead=0;
		MemWrite=1;
		SPOrALUres=0;
		SPOpeartion=01;	
		RegSrc=2;
		Data_result=0;


#20
		// push 45
		MemRead=0;
		MemWrite=1;
		SPOrALUres=0;
		SPOpeartion=01;	
		RegSrc=45;
		Data_result=0;

#20
		// pop
		MemRead=1;
		MemWrite=0;
		SPOrALUres=0;
		SPOpeartion=10;	
		RegSrc=0;
		Data_result=0;

#20
		// pop
		MemRead=1;
		MemWrite=0;
		SPOrALUres=0;
		SPOpeartion=10;	
		RegSrc=0;
		Data_result=0;

#20
		// pop
		MemRead=1;
		MemWrite=0;
		SPOrALUres=0;
		SPOpeartion=10;	
		RegSrc=0;
		Data_result=0;

#20
		MemRead=0;
		MemWrite=0;
		SPOrALUres=0;
		SPOpeartion=00;	
		RegSrc=0;
		Data_result=0;

end


endmodule
