module SavedFlages (
    input interrupt,
    input [3:0] CCR,
    output reg [3:0] SavedFlages
);

initial begin
    SavedFlages = 0;
end

always @(*) begin
    if(interrupt) SavedFlages = CCR;
    else SavedFlages=SavedFlages;
end
    
endmodule