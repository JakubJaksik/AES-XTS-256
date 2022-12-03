module AesRoundLastFun (
	input	wire	[127:0]	inData,	
    input	wire	[127:0]	inKey0,	
	input	wire	[127:0]	inKey1,	
	output	wire	[127:0]	outData 
);    
	
wire [127:0] temp0;
wire [127:0] temp1;
wire [127:0] temp2;
	
AesAddRoundKeyFun 	aesAddRoundKeyFun0 	(.inData(inData), .inKey(inKey0), .outData(temp0));
AesSubBytesFun 		aesSubBytesFun 		(.inData(temp0), .outData(temp1));
AesShiftRowsFun 	aesShiftRowsFun		(.inData(temp1), .outData(temp2));
AesAddRoundKeyFun 	aesAddRoundKeyFun1 	(.inData(temp2), .inKey(inKey1), .outData(outData));

endmodule