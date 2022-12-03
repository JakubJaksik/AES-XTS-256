module AesInvSubBytesFun (
	input	wire	[127:0]	inData,	
    output	wire	[127:0]	outData 
);

    AesInvSboxFun s00(.inData(inData[127:120]), .outData(outData[127:120]));
    AesInvSboxFun s01(.inData(inData[119:112]), .outData(outData[119:112]));
    AesInvSboxFun s02(.inData(inData[111:104]), .outData(outData[111:104]));
    AesInvSboxFun s03(.inData(inData[103: 96]), .outData(outData[103: 96]));
    AesInvSboxFun s04(.inData(inData[ 95: 88]), .outData(outData[ 95: 88]));
    AesInvSboxFun s05(.inData(inData[ 87: 80]), .outData(outData[ 87: 80]));
    AesInvSboxFun s06(.inData(inData[ 79: 72]), .outData(outData[ 79: 72]));
    AesInvSboxFun s07(.inData(inData[ 71: 64]), .outData(outData[ 71: 64]));
    AesInvSboxFun s08(.inData(inData[ 63: 56]), .outData(outData[ 63: 56]));
    AesInvSboxFun s09(.inData(inData[ 55: 48]), .outData(outData[ 55: 48]));
    AesInvSboxFun s10(.inData(inData[ 47: 40]), .outData(outData[ 47: 40]));
    AesInvSboxFun s11(.inData(inData[ 39: 32]), .outData(outData[ 39: 32]));
    AesInvSboxFun s12(.inData(inData[ 31: 24]), .outData(outData[ 31: 24]));
    AesInvSboxFun s13(.inData(inData[ 23: 16]), .outData(outData[ 23: 16]));
    AesInvSboxFun s14(.inData(inData[ 15:  8]), .outData(outData[ 15:  8]));
    AesInvSboxFun s15(.inData(inData[  7:  0]), .outData(outData[  7:  0]));
	
endmodule