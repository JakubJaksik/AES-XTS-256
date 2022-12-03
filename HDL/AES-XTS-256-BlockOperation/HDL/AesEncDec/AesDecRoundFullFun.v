module AesDecRoundFullFun (
	input	wire	[127:0]	inData,	
    input	wire	[127:0]	inKey,	
	output	wire	[127:0]	outData 
);    
	
wire [127:0] temp0;
wire [127:0] temp1;
wire [127:0] temp2;
	
AesInvMixColumnsFun	aesInvMixColumnsFun	(.inData(inData), .outData(temp0));
AesInvSubBytesFun 	aesInvSubBytesFun	(.inData(temp0), .outData(temp1));
AesInvShiftRowsFun 	aesInvShiftRowsFun	(.inData(temp1), .outData(temp2));
AesAddRoundKeyFun 	aesAddRoundKeyFun 	(.inData(temp2), .inKey(inKey), .outData(outData));


endmodule 