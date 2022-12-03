module AesDataOutReg (
input   wire          inClk, 	
input   wire          inEncWr,		
input   wire [127:0]  inEncData,	
input   wire          inDecWr,		
input   wire [127:0]  inDecData,
output  wire [127:0]  outData	
);

reg [127:0] regData = 128'b0;
   
always @ (posedge(inClk))
begin
    if (inEncWr == 1'b1) begin
        regData <= inEncData;
    end else if (inDecWr == 1'b1) begin
		regData <= inDecData;
	end
end

assign outData = regData;

endmodule