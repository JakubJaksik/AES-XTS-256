module AesSubBytesFun (
	input	wire	[127:0]	inData,	
    output	wire	[127:0]	outData 
);

    AesSboxFun s00(.inData(inData[127:120]), .outData(outData[127:120]));
    AesSboxFun s01(.inData(inData[119:112]), .outData(outData[119:112]));
    AesSboxFun s02(.inData(inData[111:104]), .outData(outData[111:104]));
    AesSboxFun s03(.inData(inData[103: 96]), .outData(outData[103: 96]));
    AesSboxFun s04(.inData(inData[ 95: 88]), .outData(outData[ 95: 88]));
    AesSboxFun s05(.inData(inData[ 87: 80]), .outData(outData[ 87: 80]));
    AesSboxFun s06(.inData(inData[ 79: 72]), .outData(outData[ 79: 72]));
    AesSboxFun s07(.inData(inData[ 71: 64]), .outData(outData[ 71: 64]));
    AesSboxFun s08(.inData(inData[ 63: 56]), .outData(outData[ 63: 56]));
    AesSboxFun s09(.inData(inData[ 55: 48]), .outData(outData[ 55: 48]));
    AesSboxFun s10(.inData(inData[ 47: 40]), .outData(outData[ 47: 40]));
    AesSboxFun s11(.inData(inData[ 39: 32]), .outData(outData[ 39: 32]));
    AesSboxFun s12(.inData(inData[ 31: 24]), .outData(outData[ 31: 24]));
    AesSboxFun s13(.inData(inData[ 23: 16]), .outData(outData[ 23: 16]));
    AesSboxFun s14(.inData(inData[ 15:  8]), .outData(outData[ 15:  8]));
    AesSboxFun s15(.inData(inData[  7:  0]), .outData(outData[  7:  0]));
	
endmodule