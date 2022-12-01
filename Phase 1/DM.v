module DMemBank(input memread, memwrite, clk, input [31:0] address, input [15:0] writedata, output reg [15:0] readdata);
  reg [15:0] mem_array [31:0];

  
// if(address > 4095) its access wrong places

  always@(posedge clk) begin
    if(memwrite)
    begin
      mem_array[address] = writedata;
    end
    else if(memread)
	begin 
	readdata = mem_array[address];
    	end
  end

endmodule