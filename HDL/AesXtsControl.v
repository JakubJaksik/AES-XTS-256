module AesXtsControl (
input	wire			inClk,
input	wire			inBlockOperationBusy,
input 	wire			inBlockOperationKeysReady,
input	wire			inAesMode,
input	wire			inExtKeyWr,
input	wire			inExtDataWr,
input	wire			inTweakValueWr,
input	wire			inBlockNrWr,
input	wire			inBlockBeforeLast,
input	wire			inLastBlock,
output	wire			outIntDataInRegIntWr,
output	wire			outIntDataInRegExtWr,
output	wire			outIntDataInRegLastBlock,
output	wire			outIntAesBlockAesMode,
output	wire			outIntAesBlockKeyWr,
output	wire			outIntAesBlockDataWr,
output	wire			outIntAesBlockTweakValueWr,
output	wire			outIntAesBlockBlockNrWr,
output	wire			outWaitingForLastBlock,
output	wire			outKeysReady,
output	wire			outBusy
);

reg			isFinished = 1'b1;
reg			LastBlock = 1'b0;

always @ (posedge(inClk))
begin
	if ((inBlockOperationKeysReady == 1'b1) && (inBlockOperationBusy == 1'b0) && (inLastBlock == 1'b1)) begin
		LastBlock <= 1'b1;
	end else if ((inBlockOperationBusy == 1'b0) && (LastBlock == 1'b1)) begin
		isFinished = 1'b1;
		LastBlock <= 1'b0;
	end else if ((isFinished == 1'b1) && (inExtKeyWr == 1'b1)) begin
		isFinished <= 1'b0;
	end
end

assign outIntDataInRegIntWr = ((inBlockOperationKeysReady == 1'b1) && (inBlockOperationBusy == 1'b0 && inLastBlock == 1'b1)) ? 1'b1 : 1'b0;
assign outIntDataInRegExtWr = ((inBlockOperationKeysReady == 1'b1) && (inBlockOperationBusy == 1'b0)) ? inExtDataWr : 1'b0;
assign outIntDataInRegLastBlock = inLastBlock;
assign outIntAesBlockAesMode = (isFinished == 1'b1) ? inAesMode : 1'b0;
assign outIntAesBlockKeyWr = (isFinished == 1'b1) ? inExtKeyWr : 1'b0;
assign outIntAesBlockDataWr = ((inBlockOperationKeysReady == 1'b1) && (inBlockOperationBusy == 1'b0)) ? inExtDataWr : 1'b0;
assign outIntAesBlockTweakValueWr = (isFinished == 1'b1) ? inTweakValueWr : 1'b0;
assign outIntAesBlockBlockNrWr = ((inBlockOperationKeysReady == 1'b1) && (inBlockOperationBusy == 1'b0)) ? inBlockNrWr : 1'b0;
assign outKeysReady = inBlockOperationKeysReady;
assign outBusy = inBlockOperationBusy;
assign outWaitingForLastBlock = !isFinished;

endmodule