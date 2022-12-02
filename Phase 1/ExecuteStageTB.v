module ExecuteStageTB();

reg clk;
reg [3:0] ALUControl;
reg [15:0] RegSrc, RegDst, immediate;
wire [3:0] newStatus;
wire [15:0] ALUResult;

ExecuteStage exe (ALUControl,RegSrc, RegDst, immediate, newStatus, ALUResult);

initial begin 	
	clk = 0;

	// ADD
	ALUControl = 4'b0000;
	RegSrc = 5;
	RegDst = 6;
	#10
	if (ALUResult == 11 && newStatus[2] == 0) begin
		$display("ADD with carry 0 success");
	end else begin
		$display("ADD with carry 0 faild");
	end
	
	#10
	RegSrc = 16'b1000000000001111;
	RegDst = 16'b1000000000001111;
	#10
	if (ALUResult == 16'b0000000000011110 && newStatus[2] == 1) begin
		$display("ADD with carry 1 success");
	end else begin
		$display("ADD with carry 1 faild");
	end

	// SUB
	#10
	ALUControl = 4'b0001;
	RegSrc = 2;
	RegDst = 5;
	#10
	if (ALUResult == 3) begin
		$display("SUB with zero 0 success");
	end else begin
		$display("SUB with zero 0 faild");
	end
	

	#10
	RegSrc = 5;
	RegDst = 5;
	#10
	if (ALUResult == 0 && newStatus[0] == 1) begin
		$display("SUB with zero 1 success");
	end else begin
		$display("SUB with zero 1 faild");
	end

	// AND
	#10
	ALUControl = 4'b0010;
	RegSrc = 5;
	RegDst = 5;
	#10
	if (ALUResult == 5) begin
		$display("AND success");
	end else begin
		$display("AND faild");
	end

	// SHL
	#10
	ALUControl = 4'b0100;
	RegSrc = 16'b0000000000001111;
	immediate = 2;
	#10
	if (ALUResult == 16'b0000000000111100) begin
		$display("SHL with carry 0 success");
	end else begin
		$display("SHL with carry 0 faild");
	end

	#10
	RegSrc = 16'b1100000000001111;
	immediate = 2;
	#10
	if (ALUResult == 16'b0000000000111100 && newStatus[2] == 1) begin
		$display("SHL with carry 1 success");
	end else begin
		$display("SHL with carry 1 faild");
	end

	// SHR
	#10
	ALUControl = 4'b0101;
	RegSrc = 16'b0000000111100000;
	immediate = 2;
	#10
	if (ALUResult == 16'b0000000001111000) begin
		$display("SHR with carry 0 success");
	end else begin
		$display("SHR with carry 0 faild");
	end

	#10
	RegSrc = 16'b0000000000001111;
	immediate = 2;
	#10
	if (ALUResult == 16'b0000000000000011 && newStatus[2] == 1) begin
		$display("SHR with carry 1 success");
	end else begin
		$display("SHR with carry 1 faild");
	end

	// NOT
	#10
	ALUControl = 4'b0110;
	RegSrc = 16'b0000000000001111;
	#10
	if (ALUResult == 16'b1111111111110000) begin
		$display("NOT success");
	end else begin
		$display("NOT faild");
	end

	// PASS First
	#10
	ALUControl = 4'b1010;
	RegSrc = 16'b0000000000000000;
	RegDst = 16'b0000000000001111;
	#10
	if (ALUResult == 16'b0000000000000000) begin
		$display("PASS First success");
	end else begin
		$display("PASS First faild");
	end

	// PASS Second
	#10
	ALUControl = 4'b0111;
	RegSrc = 16'b0000000000000000;
	RegDst = 16'b0000000000001111;
	#10
	if (ALUResult == 16'b0000000000001111) begin
		$display("PASS Second success");
	end else begin
		$display("PASS Second faild");
	end

	// INC
	#10
	ALUControl = 4'b1000;
	RegSrc = 0;
	#10
	if (ALUResult == 1) begin
		$display("INC success");
	end else begin
		$display("INC faild");
	end

	// DEC
	#10
	ALUControl = 4'b1001;
	RegSrc = 1;
	#10
	if (ALUResult == 0) begin
		$display("DEC success");
	end else begin
		$display("DEC faild");
	end

end

always #10 clk = !clk;

endmodule
