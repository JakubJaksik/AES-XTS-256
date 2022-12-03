module AesRotWordFun (
	input	wire	[31:0]	inData,	
    output	wire	[31:0]	outData 
);

assign outData = {inData[23:0], inData[31:24]};
	
endmodule