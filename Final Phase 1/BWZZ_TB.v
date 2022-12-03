module BWZZ_TB();

reg clk, reset, interrupt;

BWZZ yarb(clk, reset, interrupt)

initial begin 	
	clk = 0;
	reset = 1;
	#10

	reset = 0;



end

always #20 clk = !clk;

endmodule
