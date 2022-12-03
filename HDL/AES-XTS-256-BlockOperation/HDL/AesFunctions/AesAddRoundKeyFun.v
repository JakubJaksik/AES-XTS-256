module AesAddRoundKeyFun (
	input	wire	[127:0]	inData,	
    input	wire	[127:0]	inKey,	
	output	wire	[127:0]	outData 
);

assign outData = inData ^ inKey;
	
endmodule