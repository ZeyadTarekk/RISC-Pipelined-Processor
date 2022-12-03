module StatusRegisterTB();

reg clk;
reg reset;
reg updateStatus;
reg [1:0] carryFlag;
reg [2:0] functionCode;
reg [3:0] newStatus, savedStatus;
wire choosedBit;
wire [3:0] StatusFlags;

StatusRegister sr (updateStatus, carryFlag, functionCode, newStatus, savedStatus, reset, choosedBit, StatusFlags);

initial begin 	
	clk = 0;
	reset = 1;
	#10

	reset = 0;
	updateStatus = 1;

	// update status
	carryFlag = 2'b00;
	newStatus = 4'b1111;
	#10
	if (StatusFlags == 4'b1111) begin
		$display("Update status success");
	end else begin
		$display("Update status faild");
	end

	// clear carry
	#10
	carryFlag = 2'b01;
	newStatus = 4'b1111;
	#10
	if (StatusFlags == 4'b1011) begin
		$display("Clear carry success");
	end else begin
		$display("Clear carry faild");
	end

	// Set saved flags
	#10
	carryFlag = 2'b10;
	newStatus = 4'b1111;
	savedStatus = 4'b1010;
	#10
	if (StatusFlags == 4'b1010) begin
		$display("Set saved flags success");
	end else begin
		$display("Set saved flags faild");
	end

	// set carry
	#10
	carryFlag = 2'b11;
	newStatus = 4'b1000;
	#10
	if (StatusFlags == 4'b1110) begin
		$display("Set carry success");
	end else begin
		$display("Set carry faild");
	end

	// update status
	carryFlag = 2'b00;
	newStatus = 4'b1010;
	#10

	// get zero flag
	#10
	carryFlag = 2'bxx;
	functionCode = 3'b000;
	#10
	if (choosedBit == 1'b0) begin
		$display("Get zero flag success");
	end else begin
		$display("Get zero flag faild");
	end

	// get negative flag
	#10
	carryFlag = 2'bxx;
	functionCode = 3'b001;
	#10
	if (choosedBit == 1'b1) begin
		$display("Get negative flag success");
	end else begin
		$display("Get negative flag faild");
	end

	// get carry flag
	#10
	carryFlag = 2'bxx;
	functionCode = 3'b010;
	#10
	if (choosedBit == 1'b0) begin
		$display("Get carry flag success");
	end else begin
		$display("Get carry flag faild");
	end

	// get dummy flag
	#10
	carryFlag = 2'bxx;
	functionCode = 3'b011;
	#10
	if (choosedBit == 1'b1) begin
		$display("Get dummy flag success");
	end else begin
		$display("Get dummy flag faild");
	end

end

always #10 clk = !clk;

endmodule
