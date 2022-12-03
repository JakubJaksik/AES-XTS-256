module TbAesEnc;

/////////////////////////////////////////

parameter	inClkp = 10;
reg         inClk  = 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg					inDataWr	= 1'b0;
reg		[255:0]		inDataData	= 256'b0;
wire 	[127:0]		outData0;
wire 	[127:0]		outData1;
wire				outBusy;

reg	[255:0]	tempData  = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

AesKeySch aesKeySch(
    .inClk(inClk),
	.inDataWr(inDataWr),
    .inDataData(inDataData),
    .outData0(outData0),
    .outData1(outData1),
    .outBusy(outBusy));

always
begin
	inDataWr 	= 1'b1; inDataData <= tempData;
	#(inClkp);
	inDataWr 	= 1'b0; inDataData <= 256'b0;
	
	wait(outBusy == 1'b0 && inClk == 1'b0);
	$stop;
end

endmodule