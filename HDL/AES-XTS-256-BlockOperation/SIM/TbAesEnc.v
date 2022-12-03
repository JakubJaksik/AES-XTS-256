module TbAesEnc;

/////////////////////////////////////////

reg [63:0] TEST = 0;

/////////////////////////////////////////

parameter inClkp = 10;
reg         inClk         = 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg					inKeyWr		= 1'b0;
reg		[255:0]		inKeyData	= 256'b0;
reg					inDataWr	= 1'b0;
reg		[127:0]		inDataData  = 128'b0;
wire 	[127:0]		outData;
wire				outBusy;

reg	[255:0]	tempKey  = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
//reg	[255:0]	tempKey  = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
reg	[127:0]	tempData = 128'h00112233445566778899aabbccddeeff;

AesEnc aesEnc(
    .inClk(inClk),
    .inKeyWr(inKeyWr),
    .inKeyData(inKeyData),
    .inDataWr(inDataWr),
    .inDataData(inDataData),
    .outData(outData),
    .outBusy(outBusy));

always
begin

	TEST = TEST + 1;
	inKeyWr 	= 1'b1; inKeyData <= tempKey;
	inDataWr 	= 1'b1; inDataData <= tempData;
	#(inClkp);
    inKeyWr 	= 1'b0; inKeyData <= 512'b0;
	inDataWr 	= 1'b0; inDataData <= 256'b0;
	wait(outBusy == 1'b0 && inClk == 1'b0);
	
	tempKey		= {tempKey[127:0], tempData};
	tempData	= outData;	

	if (TEST == 64'd10) begin
		$stop;
	end 

end

endmodule
