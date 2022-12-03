module AesMultCAFun (
	input	wire	[31:0]	inData,	
    output	wire	[31:0]	outData 
);

wire [7:0] wireMN00, wireMN01, wireMN02, wireMN03;
wire [7:0] wireMN10, wireMN11, wireMN12, wireMN13;
wire [7:0] wireMN20, wireMN21, wireMN22, wireMN23;
wire [7:0] wireMN30, wireMN31, wireMN32, wireMN33;

AesMult02Fun mn00 (.inData(inData[31:24]), .outData(wireMN00));
AesMult03Fun mn01 (.inData(inData[23:16]), .outData(wireMN01));
AesMult01Fun mn02 (.inData(inData[15:08]), .outData(wireMN02));
AesMult01Fun mn03 (.inData(inData[07:00]), .outData(wireMN03));

AesMult01Fun mn10 (.inData(inData[31:24]), .outData(wireMN10));
AesMult02Fun mn11 (.inData(inData[23:16]), .outData(wireMN11));
AesMult03Fun mn12 (.inData(inData[15:08]), .outData(wireMN12));
AesMult01Fun mn13 (.inData(inData[07:00]), .outData(wireMN13));

AesMult01Fun mn20 (.inData(inData[31:24]), .outData(wireMN20));
AesMult01Fun mn21 (.inData(inData[23:16]), .outData(wireMN21));
AesMult02Fun mn22 (.inData(inData[15:08]), .outData(wireMN22));
AesMult03Fun mn23 (.inData(inData[07:00]), .outData(wireMN23));

AesMult03Fun mn30 (.inData(inData[31:24]), .outData(wireMN30));
AesMult01Fun mn31 (.inData(inData[23:16]), .outData(wireMN31));
AesMult01Fun mn32 (.inData(inData[15:08]), .outData(wireMN32));
AesMult02Fun mn33 (.inData(inData[07:00]), .outData(wireMN33));

assign outData[31:24] = wireMN00 ^ wireMN01 ^ wireMN02 ^ wireMN03;
assign outData[23:16] = wireMN10 ^ wireMN11 ^ wireMN12 ^ wireMN13;
assign outData[15:08] = wireMN20 ^ wireMN21 ^ wireMN22 ^ wireMN23;
assign outData[07:00] = wireMN30 ^ wireMN31 ^ wireMN32 ^ wireMN33;
	 
endmodule