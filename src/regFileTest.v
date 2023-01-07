`include "regfile.v"

module reg_tb ();

  reg write_enable, rst, clk;
  reg [4:0] read_addr, write_addr;
  reg  [15:0] write_data;
  wire [15:0] read_data;

  localparam N = 10;

  regFile testReg (
      write_enable,
      read_data,
      write_data,
      clk,
      rst,
      read_addr,
      write_addr
  );
  initial begin

    clk = 1'b0;
    rst = 1'b0;


    #N write_enable = 1'b1;
    write_data = 16'b1111000011110000;
    write_addr = 5'b00001;

    clk = 1'b1;

    #N clk = 1'b0;

    #N read_addr = 5'b00001;

    clk = 1'b1;
    #N clk = 1'b0;
    #N
      if (read_data == 16'b1111000011110000) begin
        $display("Read after write Passed");
      end else begin
        $display("Read after write  Failed");
      end

    rst = 1'b1;

    clk = 1'b1;
    #N clk = 1'b0;
    #N clk = 1'b1;
    #N clk = 1'b0;

    #N read_addr = 5'b00001;

    clk = 1'b1;
    #N clk = 1'b0;
    #N

      if (read_data == 16'b0000000000000000) begin
        $display("reset Passed");
      end else begin
        $display("reset Failed");
      end

  end

endmodule
