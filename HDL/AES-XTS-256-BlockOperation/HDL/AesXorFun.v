module AesBlockXorFun (
input	wire [127:0]	inData0,
input	wire [127:0]	inData1,
output	wire [127:0]	outData
);

assign outData = inData0 ^ inData1;

endmodule