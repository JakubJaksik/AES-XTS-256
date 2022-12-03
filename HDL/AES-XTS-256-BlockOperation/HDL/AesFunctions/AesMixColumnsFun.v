module AesMixColumnsFun (
	input	wire	[127:0]	inData,	
    output	wire	[127:0]	outData 
);
     
AesMultCAFun col0 (.inData(inData[127:096]), .outData(outData[127:096]));
AesMultCAFun col1 (.inData(inData[095:064]), .outData(outData[095:064]));
AesMultCAFun col2 (.inData(inData[063:032]), .outData(outData[063:032]));
AesMultCAFun col3 (.inData(inData[031:000]), .outData(outData[031:000]));
    
endmodule