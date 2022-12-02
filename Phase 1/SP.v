module SP (
    input [1:0] SPOpeartion,
    input clk,
    rst,
    output reg [31:0] SPValue
);
  reg [31:0] sp;

  always @(posedge rst) begin
    sp = 4095;
  end

  always @(posedge clk) begin
    if (SPOpeartion == 2'b10) begin
      sp <= sp + 1;
      SPValue = sp + 1'b1;
    end else if (SPOpeartion == 2'b01) begin
      SPValue = sp;
      sp <= sp - 1'b1;
    end
  end

endmodule
