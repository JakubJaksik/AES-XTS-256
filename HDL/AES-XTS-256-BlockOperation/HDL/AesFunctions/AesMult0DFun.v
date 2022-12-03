module AesMult0DFun (
   input   wire   [7:0]  inData,
   output  wire   [7:0]  outData
);

assign outData[0] = inData[5] ^ inData[6] ^ inData[0];
assign outData[1] = inData[7] ^ inData[6] ^ inData[6] ^ inData[5] ^ inData[1];
assign outData[2] = inData[7] ^ inData[6] ^ inData[0] ^ inData[7] ^ inData[2];
assign outData[3] = inData[1] ^ inData[6] ^ inData[0] ^ inData[7] ^ inData[5] ^ inData[3];
assign outData[4] = inData[1] ^ inData[6] ^ inData[5] ^ inData[2] ^ inData[7] ^ inData[6] ^ inData[4];
assign outData[5] = inData[3] ^ inData[7] ^ inData[2] ^ inData[7] ^ inData[6] ^ inData[5];
assign outData[6] = inData[4] ^ inData[3] ^ inData[7] ^ inData[6];
assign outData[7] = inData[5] ^ inData[4] ^ inData[7];

endmodule

