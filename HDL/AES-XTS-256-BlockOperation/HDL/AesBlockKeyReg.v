module AesBlockKeyReg (
input	wire			inClk,
input	wire			inWr,
input	wire [511:0]	inKey,
input	wire			inAddr,
output	wire [255:0]	outKey
);

reg	[511:0] regKey = 512'b0;

always @ (posedge(inClk))
begin	
	if (inWr == 1'b1) begin
		regKey <= inKey;
	end
end

assign outKey = (inAddr == 1'b0) ? regKey[255:0] : regKey[511:256];

endmodule