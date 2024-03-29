module regFile (
    write_enable,
    read_data1,
    read_data2,
    inport,
    write_data,
    clk,
    rst,
    read_addr1,
    read_addr2,
    write_addr,
    privateRegWrite,
    privateRegResult,
    PC,
    outport
);

  input write_enable, rst, clk ,privateRegWrite;
  input [3:0] read_addr1,read_addr2, write_addr;
  input [15:0] write_data,inport;
  input [31:0] PC;
  output reg [15:0] read_data1,outport;
  output reg [15:0] read_data2;
  output [31:0] privateRegResult;
  integer i;
  reg [15:0] registers[15:0];

	always @(privateRegWrite) begin
		#2;
    if(privateRegWrite == 1'b1) begin
      registers[9] = PC[15:0];
      registers[10] = PC[31:16];
    end
	end
  
  assign registers[8] = inport;
  assign outport = registers[8];

  always @(posedge clk, rst) begin
    // check first if the rst is set as it has highest priority
    if (rst == 1'b1) begin
      for (i = 0; i < 32; i = i + 1) begin
        registers[i] = 0;
      end
    end

    if (write_enable == 1'b1) begin
      registers[write_addr] = write_data;
    end

  end

  always @(negedge clk, rst) begin
    if (rst == 1'b1) begin
      for (i = 0; i < 32; i = i + 1) begin
        registers[i] = 0;
      end
    end
    read_data1 = registers[read_addr1];
    read_data2 = registers[read_addr2];
  end
	assign privateRegResult = {registers[10], registers[9]};

endmodule
