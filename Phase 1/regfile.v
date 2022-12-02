module regFile (
    write_enable,
    read_data,
    write_data,
    clk,
    rst,
    read_addr,
    write_addr
);
  input write_enable, rst, clk;
  input [4:0] read_addr, write_addr;
  input [15:0] write_data;
  output reg [15:0] read_data;
  integer i;
  reg [31:0] registers[15:0];

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
    read_data = registers[read_addr];
  end

endmodule