module AesControl (
input   wire        inClk,			
input	wire		inAesMode,			
input   wire        inExtDataWr,		
output  wire        outIntRoundRegExtEncWr,
output  wire        outIntRoundRegExtDecWr,
output  wire        outIntRoundRegIntEncWr,
output  wire        outIntRoundRegIntDecWr,
output  wire        outIntDataOutRegEncWr,	
output  wire        outIntDataOutRegDecWr,	
output  wire        outBusy				
);

reg [7:0] 	regCounter = 8'b0;
reg 		regAesMode = 1'b0;

always @ (posedge(inClk))
begin
	if ((inExtDataWr == 1'b1) && (regCounter == 8'b0)) begin
		regAesMode <= inAesMode;
	end
	
    if ((inExtDataWr == 1'b1) || (regCounter != 8'b0)) begin
        if (regCounter == 8'd14) begin
            regCounter <= 8'b0;
        end else begin
            regCounter <= regCounter + 8'd1;
        end
    
    end
end

assign outIntRoundRegExtEncWr = ((regCounter == 8'd0) && (regAesMode == 1'b0)) ? inExtDataWr : 1'b0;

assign outIntRoundRegExtDecWr = ((regCounter == 8'd1) && (regAesMode == 1'b1)) ? inExtDataWr : 1'b0;

assign outIntRoundRegIntEncWr = ((regCounter != 8'd0) && (regAesMode == 1'b0)) ? 1'b1 : 1'b0;

assign outIntRoundRegIntDecWr = ((regCounter != 8'd0) && (regAesMode == 1'b1)) ? 1'b1 : 1'b0;

assign outIntDataOutRegEncWr = ((regCounter == 8'd14) && (regAesMode == 1'b0)) ? 1'b1 : 1'b0;

assign outIntDataOutRegDecWr = ((regCounter == 8'd14) && (regAesMode == 1'b1)) ? 1'b1 : 1'b0;

assign outBusy = (regCounter == 8'd0) ? 1'b0 : 1'b1;

endmodule