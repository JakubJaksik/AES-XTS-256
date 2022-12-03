module AesKeySchReg (
input   wire          	inClk,			
input   wire          	inExtWr,	
input   wire [255:0]  	inExtData,	
input   wire          	inIntWr,	
input   wire [255:0]	inIntData,	
input   wire [7:0]    	inIntRcon,	
output  wire [255:0]  	outIntData,	
output  wire [7:0]    	outIntRcon,	
output  wire [255:0]  	outExtData,
);

reg 	[255:0]	regData = 256'b0;
reg 	[7:0] 	regRcon = 8'b1;
  
always @ (posedge(inClk))
begin
    if (inExtWr == 1'b1) begin
        regData <= inExtData;
		regRcon <= 8'b1;
    end
    
    if (inIntWr == 1'b1) begin
        regData <= inIntData;
		regRcon <= inIntRcon;
    end
end

assign outIntData = regData;
assign outIntRcon = regRcon;
assign outExtData = regData;

endmodule
