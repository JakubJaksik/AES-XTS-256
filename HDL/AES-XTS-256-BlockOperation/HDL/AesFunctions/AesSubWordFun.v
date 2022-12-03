module AesSubWordFun (
	input	wire	[31:0]	inData,	
    output	wire	[31:0]	outData 
);

AesSboxFun s0(.inData(inData[ 31: 24]), .outData(outData[ 31: 24]));
AesSboxFun s1(.inData(inData[ 23: 16]), .outData(outData[ 23: 16]));
AesSboxFun s2(.inData(inData[ 15:  8]), .outData(outData[ 15:  8]));
AesSboxFun s3(.inData(inData[  7:  0]), .outData(outData[  7:  0]));
	
endmodule