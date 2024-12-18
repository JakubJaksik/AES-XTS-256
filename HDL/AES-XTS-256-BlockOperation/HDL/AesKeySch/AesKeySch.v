module AesKeySch (
input	wire			inClk,
input	wire			inWr,
input	wire [255:0]	inKey,
output	wire [255:0]	outRoundKey,
output	wire			outBusy
);

wire 			wireAesControloutIntKeyschRegExtWr;
wire 			wireAesControloutIntKeyschRegIntWr;
wire 			wireAesControloutIntKeyschFunoutMode;

wire [255:0]    wireAesKeyschFunoutData;
wire [7:0]    	wireAesKeyschFunoutRcon;
wire [255:0]    wireAesKeyschRegoutIntData;
wire [7:0]    	wireAesKeyschRegoutIntRcon;

AesKeySchControl AesKeySchControl(
				.inClk(inClk),
				.inExtKeyWr(inWr),
				.outIntKeySchRegExtWr(wireAesControloutIntKeyschRegExtWr),
				.outIntKeySchRegIntWr(wireAesControloutIntKeyschRegIntWr),
				.outIntKeySchFunMode(wireAesControloutIntKeyschFunoutMode),
				.outBusy(outBusy));
				
AesKeySchFun AesKeySchFun(
				.inMode(wireAesControloutIntKeyschFunoutMode),	
				.inData(wireAesKeyschRegoutIntData),	
				.inRcon(wireAesKeyschRegoutIntRcon),	
				.outData(wireAesKeyschFunoutData),
				.outRcon(wireAesKeyschFunoutRcon));
				
AesKeySchReg AesKeySchReg(
                .inClk(inClk),
                .inExtWr(wireAesControloutIntKeyschRegExtWr),
                .inExtData(inKey),
                .inIntWr(wireAesControloutIntKeyschRegIntWr),
                .inIntData(wireAesKeyschFunoutData),
                .inIntRcon(wireAesKeyschFunoutRcon),
                .outIntData(wireAesKeyschRegoutIntData),
                .outIntRcon(wireAesKeyschRegoutIntRcon),
				.outExtData(outRoundKey));

endmodule