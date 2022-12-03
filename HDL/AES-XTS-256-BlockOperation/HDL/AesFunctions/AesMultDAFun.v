module AesMultDAFun (
   input   wire   [31:0]   inData,
   output  wire   [31:0]   outData
);

wire [7:0] wireMN00, wireMN01, wireMN02, wireMN03;
wire [7:0] wireMN10, wireMN11, wireMN12, wireMN13;
wire [7:0] wireMN20, wireMN21, wireMN22, wireMN23;
wire [7:0] wireMN30, wireMN31, wireMN32, wireMN33;

AesMult0EFun mn00 (.inData(inData[31:24]), .outData(wireMN00));
AesMult0BFun mn01 (.inData(inData[23:16]), .outData(wireMN01));
AesMult0DFun mn02 (.inData(inData[15:08]), .outData(wireMN02));
AesMult09Fun mn03 (.inData(inData[07:00]), .outData(wireMN03));

AesMult09Fun mn10 (.inData(inData[31:24]), .outData(wireMN10));
AesMult0EFun mn11 (.inData(inData[23:16]), .outData(wireMN11));
AesMult0BFun mn12 (.inData(inData[15:08]), .outData(wireMN12));
AesMult0DFun mn13 (.inData(inData[07:00]), .outData(wireMN13));

AesMult0DFun mn20 (.inData(inData[31:24]), .outData(wireMN20));
AesMult09Fun mn21 (.inData(inData[23:16]), .outData(wireMN21));
AesMult0EFun mn22 (.inData(inData[15:08]), .outData(wireMN22));
AesMult0BFun mn23 (.inData(inData[07:00]), .outData(wireMN23));

AesMult0BFun mn30 (.inData(inData[31:24]), .outData(wireMN30));
AesMult0DFun mn31 (.inData(inData[23:16]), .outData(wireMN31));
AesMult09Fun mn32 (.inData(inData[15:08]), .outData(wireMN32));
AesMult0EFun mn33 (.inData(inData[07:00]), .outData(wireMN33));

assign outData[31:24] = wireMN00 ^ wireMN01 ^ wireMN02 ^ wireMN03;
assign outData[23:16] = wireMN10 ^ wireMN11 ^ wireMN12 ^ wireMN13;
assign outData[15:08] = wireMN20 ^ wireMN21 ^ wireMN22 ^ wireMN23;
assign outData[07:00] = wireMN30 ^ wireMN31 ^ wireMN32 ^ wireMN33;
	 
endmodule