module AesSimpleMem (
input	wire			inClk,
input	wire			inWr,
input	wire			inRd,
input	wire	[3:0]	inAddr,
input	wire	[255:0]	inData,
output	reg		[255:0]	outData
);

reg	[3:0]	memMemory	[0:255];

always @ (posedge(inClk))
begin
    if (inWr == 1'b1) begin
        memMemory[inAddr] <= inData;
    end 
end

always @ (posedge(inClk))
begin
    if (inRd == 1'b1) begin
        outData <= memMemory[inAddr];
    end else begin
        outData <= 256'bz;
    end 
end

endmodule
