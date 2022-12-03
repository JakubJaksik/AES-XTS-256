module AesKeySchFun (
input   wire          	inMode,		
input   wire [255:0]  	inData,		
input 	wire [7:0]		inRcon,		
output  wire [255:0]	outData,	
output  wire [7:0]    	outRcon		
);

wire	[31:0]	wireRotWordOut;
wire	[31:0]	wireSubWordIn;
wire	[31:0]	wireSubWordOut;
wire	[31:0]	wireRconOut;

AesRotWordFun aesRotWordFun (.inData(inData[31:0]), .outData(wireRotWordOut));

assign wireSubWordIn = (inMode == 1'b1) ? wireRotWordOut : inData[31:0];
     
AesSubWordFun aesSubWordFun (.inData(wireSubWordIn), .outData(wireSubWordOut));

assign wireRconOut = (inMode == 1'b1) ? wireSubWordOut ^ {inRcon, 24'b0} : wireSubWordOut;    
        
assign outData[255:128] = inData[127:0];
assign outData[127: 96] = wireRconOut ^ inData[255:224];
assign outData[ 95: 64] = wireRconOut ^ inData[255:224] ^ inData[223:192];
assign outData[ 63: 32] = wireRconOut ^ inData[255:224] ^ inData[223:192] ^ inData[191:160];
assign outData[ 31:  0] = wireRconOut ^ inData[255:224] ^ inData[223:192] ^ inData[191:160] ^ inData[159:128];

assign outRcon = (inMode == 1'b1) ? inRcon : {inRcon[6:0], inRcon[7]};

endmodule