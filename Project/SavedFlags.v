module SavedFlages (
    input intrrupt,
    input [3:0] CCR,
    output reg [3:0] SavedFlages
);

always @(*) begin
    if(intrrupt) SavedFlages = CCR;
    else SavedFlages=SavedFlages;
end
    
endmodule