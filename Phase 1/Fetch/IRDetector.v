module IRDetector (
    input [15:0] iR,
    input clk,
    output [15:0] instruction,
    immediate
);

  reg flag = 0;

  always @(posedge clk) begin
    if (iR[2]) flag = 1;

    instruction = iR;

    if (flag) begin
      immediate = iR;
      flag = 0;
    end

  end


endmodule
