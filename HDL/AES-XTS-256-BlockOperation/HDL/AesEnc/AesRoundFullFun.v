module AesRoundFullFun (
	input	wire	[127:0]	inData,	
    input	wire	[127:0]	inKey,	
	output	wire	[127:0]	outData 
);    
	
wire [127:0] temp0;
wire [127:0] temp1;
wire [127:0] temp2;
	
AesAddRoundKeyFun 	aesAddRoundKeyFun 	(.inData(inData), .inKey(inKey), .outData(temp0));
AesSubBytesFun 		aesSubBytesFun 		(.inData(temp0), .outData(temp1));
AesShiftRowsFun 	aesShiftRowsFun		(.inData(temp1), .outData(temp2));
AesMixColumnsFun	aesMixColumnsFun	(.inData(temp2), .outData(outData));

endmodule 