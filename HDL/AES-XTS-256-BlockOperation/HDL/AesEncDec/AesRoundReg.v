module AesRoundReg (
input   wire          inClk,		
input   wire          inExtEncWr,		
input   wire [127:0]  inExtEncData,	
input   wire          inExtDecWr,		
input   wire [127:0]  inExtDecData,	
input   wire          inIntEncWr,		
input   wire [127:0]  inIntEncData,	
input   wire          inIntDecWr,		
input   wire [127:0]  inIntDecData,
output  wire [127:0]  outData		
);

reg [127:0] regData = 128'b0;

always @ (posedge(inClk))
begin
    if (inExtEncWr == 1'b1) begin
        regData <= inExtEncData;
    end  else if (inExtDecWr == 1'b1) begin
		regData <= inExtDecData;
	end else if (inIntEncWr == 1'b1) begin
        regData <= inIntEncData;
    end else if (inIntDecWr == 1'b1) begin
        regData <= inIntDecData;
    end
end

assign outData = regData;

endmodule