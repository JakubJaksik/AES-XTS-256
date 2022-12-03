module AesBlockEnc (
input	wire			inClk,
input	wire [255:0]	inKeyData,
input	wire			inDataWr,
input	wire [127:0]	inDataData,
output	wire [127:0]	outData,
output	wire			outBusy
);

wire 			wireAesControloutIntRoundRegExtWr;
wire 			wireAesControloutIntRoundRegIntWr;
wire 			wireAesControloutIntDataOutRegWr;

wire [127:0]    wireAesRoundFullFunoutData;
wire [127:0]    wireAesRoundLastFunoutData;
wire [127:0]    wireAesRoundRegoutData;

AesControl AesControl(
                .inClk(inClk),
                .inExtDataWr(inDataWr),
				.outIntRoundRegExtWr(wireAesControloutIntRoundRegExtWr),
                .outIntRoundRegIntWr(wireAesControloutIntRoundRegIntWr),
                .outIntDataOutRegWr(wireAesControloutIntDataOutRegWr),
                .outBusy(outBusy));
			
AesRoundReg AesRoundReg(
                .inClk(inClk),
                .inExtWr(wireAesControloutIntRoundRegExtWr),
                .inExtData(inDataData),
                .inIntWr(wireAesControloutIntRoundRegIntWr),
                .inIntData(wireAesRoundFullFunoutData),
                .outData(wireAesRoundRegoutData));

AesRoundFullFun AesRoundFullFun(
                .inData(wireAesRoundRegoutData),
                .inKey(inKeyData[127:0]),
                .outData(wireAesRoundFullFunoutData));

AesRoundLastFun AesRoundLastFun(
                .inData(wireAesRoundRegoutData),
                .inKey0(inKeyData[127:0]),
                .inKey1(inKeyData[255:128]),
                .outData(wireAesRoundLastFunoutData));
			
AesDataOutReg AesDataOutReg (
                .inClk(inClk),
                .inWr(wireAesControloutIntDataOutRegWr),
                .inData(wireAesRoundLastFunoutData),
                .outData(outData));

endmodule