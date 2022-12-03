module AesXtsDataInReg (
input	wire			inClk,
input	wire			inIntWr,
input	wire [127:0]	inIntData,
input	wire			inExtWr,
input	wire [127:0]	inExtData,
input	wire			inLastBlock,
input	wire [7:0]		inExtSizeLastData,
output	wire [127:0]	outData
);

reg [127:0]	regData = 128'b0;

always @ (posedge(inClk))
begin
	if (inLastBlock == 1'b0) begin
		if (inExtWr == 1'b1) begin
			regData <= inExtData;
		end
	end else begin
		if ((inExtWr == 1'b1) && (inIntWr == 1'b1))begin
			regData <= { (inIntData & ((2**(128 - inExtSizeLastData) - 1)) << (128 - inExtSizeLastData)) ^ (inExtData & (2**(inExtSizeLastData)-1))};
		end
	end
end

assign outData = regData;

endmodule