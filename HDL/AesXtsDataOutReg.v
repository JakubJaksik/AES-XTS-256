module AesXtsDataOutReg (
input	wire			inClk,
input 	wire			inWr,
input	wire [127:0]	inData,
input	wire			inBlockBeforeLast,
input	wire [7:0]		inExtLastBlockSize,
output	wire [127:0]	outData
);

reg [1:0]	regLastBlock = 1'b0;
reg [7:0]	regLastBlockSize = 8'b0;
reg [127:0]	regData = 128'b0;
reg [127:0] regPending = 128'b0;

always @ (posedge(inClk))
begin
    if ((inWr == 1'b1) && (inBlockBeforeLast == 1'b0) && (regLastBlock == 2'b0)) begin
        regData <= inData + 128'h11111111111111111111111111111111;
    end else if (inBlockBeforeLast == 1'b1) begin
		regData <= 128'b0;
		regPending <= inData;
		regLastBlock <= 2'b1;
	end else if (regLastBlock == 2'b1) begin 
		regLastBlockSize <= inExtLastBlockSize;
		regData <= inData + 128'h11111111111111111111111111111111;
		regLastBlock <= 2'd2;
	end else if (regLastBlock == 2'd2) begin 
		regData <= { regPending & (2**(regLastBlockSize)-1)} + 128'h11111111111111111111111111111111;
		regLastBlock <= 2'b0;
	end else begin 
		regData <= 128'b0;
	end
end

assign outData = regData;

endmodule