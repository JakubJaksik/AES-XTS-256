module AesShiftRowsFun (
	input	wire	[127:0]	inData,	
    output	wire	[127:0]	outData 
);

    assign outData[127:120] = inData[127:120];
    assign outData[119:112] = inData[ 87: 80];
    assign outData[111:104] = inData[ 47: 40];
    assign outData[103: 96] = inData[  7:  0];
	
    assign outData[ 95: 88] = inData[ 95: 88];
    assign outData[ 87: 80] = inData[ 55: 48];
    assign outData[ 79: 72] = inData[ 15:  8];
    assign outData[ 71: 64] = inData[103: 96];
	
    assign outData[ 63: 56] = inData[ 63: 56];
    assign outData[ 55: 48] = inData[ 23: 16];
    assign outData[ 47: 40] = inData[111:104];
    assign outData[ 39: 32] = inData[ 71: 64];
	
    assign outData[ 31: 24] = inData[ 31: 24];
    assign outData[ 23: 16] = inData[119:112];
    assign outData[ 15:  8] = inData[ 79: 72];
    assign outData[  7:  0] = inData[ 39: 32];

endmodule