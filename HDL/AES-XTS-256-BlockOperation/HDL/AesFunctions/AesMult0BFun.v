module AesMult0BFun (
   input   wire   [7:0]  inData,
   output  wire   [7:0]  outData
);

assign outData[0] = inData[0] ^ inData[5] ^ inData[7];
assign outData[1] = inData[1] ^ inData[6] ^ inData[5] ^ inData[0] ^ inData[7];
assign outData[2] = inData[2] ^ inData[7] ^ inData[6] ^ inData[1];
assign outData[3] = inData[3] ^ inData[0] ^ inData[7] ^ inData[5] ^ inData[2] ^ inData[7];
assign outData[4] = inData[4] ^ inData[1] ^ inData[6] ^ inData[5] ^ inData[3] ^ inData[7];
assign outData[5] = inData[5] ^ inData[2] ^ inData[7] ^ inData[6] ^ inData[4];
assign outData[6] = inData[6] ^ inData[3] ^ inData[7] ^ inData[5];
assign outData[7] = inData[7] ^ inData[4] ^ inData[6];

endmodule