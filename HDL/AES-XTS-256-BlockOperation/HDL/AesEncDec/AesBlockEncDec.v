module AesBlockEncDec (
input	wire			inClk,
input	wire			inAesMode,
input	wire [255:0]	inKeyData,
input	wire			inDataWr,
input	wire [127:0]	inDataData,
output	wire [127:0]	outData,
output	wire			outBusy
);

wire 			wireAesControloutIntRoundRegExtEncWr;
wire			wireAesControloutIntRoundRegExtDecWr;
wire 			wireAesControloutIntRoundRegIntEncWr;
wire 			wireAesControloutIntRoundRegIntDecWr;
wire 			wireAesControloutIntDataOutRegEncWr;
wire 			wireAesControloutIntDataOutRegDecWr;

wire [127:0]    wireAesRoundFullFunoutEncData;
wire [127:0]    wireAesRoundFullFunoutDecData;
wire [127:0]    wireAesRoundLastFunoutEncData;
wire [127:0]    wireAesRoundFirstFunoutExtDecData;
wire [127:0]    wireAesRoundRegoutData;

AesControl AesControl(
                .inClk(inClk),
				.inAesMode(inAesMode),
                .inExtDataWr(inDataWr),
				.outIntRoundRegExtEncWr(wireAesControloutIntRoundRegExtEncWr),
				.outIntRoundRegExtDecWr(wireAesControloutIntRoundRegExtDecWr),
                .outIntRoundRegIntEncWr(wireAesControloutIntRoundRegIntEncWr),
				.outIntRoundRegIntDecWr(wireAesControloutIntRoundRegIntDecWr),
                .outIntDataOutRegEncWr(wireAesControloutIntDataOutRegEncWr),
				.outIntDataOutRegDecWr(wireAesControloutIntDataOutRegDecWr),
                .outBusy(outBusy));
			
AesRoundReg AesRoundReg(
                .inClk(inClk),
                .inExtEncWr(wireAesControloutIntRoundRegExtEncWr),
                .inExtEncData(inDataData),
				.inExtDecWr(wireAesControloutIntRoundRegExtDecWr),
				.inExtDecData(wireAesRoundFirstFunoutExtDecData),
                .inIntEncWr(wireAesControloutIntRoundRegIntEncWr),
                .inIntEncData(wireAesRoundFullFunoutEncData),
				.inIntDecWr(wireAesControloutIntRoundRegIntDecWr),
                .inIntDecData(wireAesRoundFullFunoutDecData),
                .outData(wireAesRoundRegoutData));

AesEncRoundFullFun AesEncRoundFullFun(
                .inData(wireAesRoundRegoutData),
                .inKey(inKeyData[127:0]),
                .outData(wireAesRoundFullFunoutEncData));

AesEncRoundLastFun AesEncRoundLastFun(
                .inData(wireAesRoundRegoutData),
                .inKey0(inKeyData[127:0]),
                .inKey1(inKeyData[255:128]),
                .outData(wireAesRoundLastFunoutEncData));
				
AesDecRoundFirstFun AesDecRoundFirstFun(
                .inData(inDataData),
                .inKey0(inKeyData[127:0]),
                .inKey1(inKeyData[255:128]),
                .outData(wireAesRoundFirstFunoutExtDecData));
				
AesDecRoundFullFun AesDecRoundFullFun(
                .inData(wireAesRoundRegoutData),
                .inKey(inKeyData[127:0]),
                .outData(wireAesRoundFullFunoutDecData));
			
AesDataOutReg AesDataOutReg (
                .inClk(inClk),
                .inEncWr(wireAesControloutIntDataOutRegEncWr),
                .inEncData(wireAesRoundLastFunoutEncData),
				.inDecWr(wireAesControloutIntDataOutRegDecWr),
				.inDecData(wireAesRoundRegoutData),
                .outData(outData));

endmodule