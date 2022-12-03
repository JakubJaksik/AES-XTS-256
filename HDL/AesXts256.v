module AesXts256 (
input	wire			inClk,
input	wire 			inAesMode,	// 0 - szyfrowanie, 1 - deszyfrowanie, domyślnie 0. Należy podać wcześniej lub razem z kluczem 
input	wire			inKeyWr,
input	wire [511:0]	inKeyData,
input	wire			inDataWr,
input	wire [127:0]	inDataData,
input	wire			inTweakValueWr,
input	wire [127:0]	inTweakValueData,
input	wire			inBlockNrWr,
input	wire [127:0]	inBlockNrData,
input	wire			inBlockBeforeLast,
input	wire			inLastBlock,
input	wire [7:0]		inSizeLastData,
output	wire [127:0]	outData,
output	wire			outWaitingForLastBlock,
output	wire			outKeysReady,
output	wire			outBusy
);

wire			aesXtsControloutIntDataInRegIntWr;
wire			aesXtsControloutIntDataInRegExtWr;
wire			aesXtsControloutIntDataInRegLastBlock;
wire			aesXtsControloutIntBlockOperationAesMode;
wire			aesXtsControloutIntBlockOperationKeyWr;
wire			aesXtsControloutIntBlockOperationDataWr;
wire			aesXtsControloutIntBlockOperationTweakValueWr;
wire			aesXtsControloutIntBlockOperationBlockNrWr;
wire			aesXtsControloutIntDataOutRegWr;
wire			aesXtsControloutIntDataOutRegBlockBeforeLastWr;
wire			aesXtsBlockOperationoutBusy;
wire			aesXtsBlockOperationKeysReady;

wire [127:0]	aesXtsDataInRegoutData;
wire [127:0]	aesXtsBlockOperationoutData;

AesXtsControl AesXtsControl(
				.inClk(inClk),
				.inBlockOperationBusy(aesXtsBlockOperationoutBusy),
				.inBlockOperationKeysReady(aesXtsBlockOperationKeysReady),
				.inAesMode(inAesMode),
				.inExtKeyWr(inKeyWr),
				.inExtDataWr(inDataWr),
				.inTweakValueWr(inTweakValueWr),
				.inBlockNrWr(inBlockNrWr),
				.inBlockBeforeLast(inBlockBeforeLast),
				.inLastBlock(inLastBlock),
				.outIntDataInRegIntWr(aesXtsControloutIntDataInRegIntWr),
				.outIntDataInRegExtWr(aesXtsControloutIntDataInRegExtWr),
				.outIntDataInRegLastBlock(aesXtsControloutIntDataInRegLastBlock),
				.outIntAesBlockAesMode(aesXtsControloutIntBlockOperationAesMode),
				.outIntAesBlockKeyWr(aesXtsControloutIntBlockOperationKeyWr),
				.outIntAesBlockDataWr(aesXtsControloutIntBlockOperationDataWr),
				.outIntAesBlockTweakValueWr(aesXtsControloutIntBlockOperationTweakValueWr),
				.outIntAesBlockBlockNrWr(aesXtsControloutIntBlockOperationBlockNrWr),
				.outWaitingForLastBlock(outWaitingForLastBlock),
				.outKeysReady(outKeysReady),
				.outBusy(outBusy));

AesXtsDataInReg AesXtsDataInReg(
				.inClk(inClk),
				.inIntWr(aesXtsControloutIntDataInRegIntWr),
				.inExtWr(aesXtsControloutIntDataInRegExtWr),
				.inIntData(aesXtsBlockOperationoutData),
				.inExtData(inDataData),
				.inLastBlock(aesXtsControloutIntDataInRegLastBlock),
				.inExtSizeLastData(inSizeLastData),
				.outData(aesXtsDataInRegoutData));
				
AesXtsBlockOperation AesXtsBlockOperation(
				.inClk(inClk),
				.inAesMode(aesXtsControloutIntBlockOperationAesMode),
				.inKeyWr(aesXtsControloutIntBlockOperationKeyWr),
				.inKeyData(inKeyData),
				.inDataWr(aesXtsControloutIntBlockOperationDataWr),
				.inDataData(aesXtsDataInRegoutData),
				.inTweakValueWr(aesXtsControloutIntBlockOperationTweakValueWr),
				.inTweakValueData(inTweakValueData),
				.inBlockNrWr(aesXtsControloutIntBlockOperationBlockNrWr),
				.inBlockNrData(inBlockNrData),
				.outData(aesXtsBlockOperationoutData),
				.outKeysReady(aesXtsBlockOperationKeysReady),
				.outBusy(aesXtsBlockOperationoutBusy));
				
AesXtsDataOutReg AesXtsDataOutReg(
				.inClk(inClk),
				.inData(aesXtsBlockOperationoutData),
				.inWr(aesXtsControloutIntDataOutRegWr),
				.inBlockBeforeLast(aesXtsControloutIntDataOutRegBlockBeforeLastWr),
				.inExtLastBlockSize(inSizeLastData),
				.outData(outData));
				
endmodule

// AES-256-BLOCK-OPERATION
// Po podaniu klucza:
// Busy = 1 ready = 0
// po wyznaczeniu kluczy rundowych dla AES2 
// Busy = 0 ready = 1, oczekiwanie na podanie danych