module AesControl (
input   wire        inClk,						
input   wire        inExtDataWr,		
output  wire        outIntRoundRegExtWr,
output  wire        outIntRoundRegIntWr,
output  wire        outIntDataOutRegWr,	
output  wire        outBusy				
);

reg [7:0] regCounter = 8'b0;

always @ (posedge(inClk))
begin
    if ((inExtDataWr == 1'b1) || (regCounter != 8'b0)) begin
        if (regCounter == 8'd14) begin
            regCounter <= 8'b0;
        end else begin
            regCounter <= regCounter + 8'd1;
        end
    
    end
end

assign outIntRoundRegExtWr = (regCounter == 8'd0) ? inExtDataWr : 1'b0;

assign outIntRoundRegIntWr = (regCounter == 8'd0) ? 1'b0 : 1'b1;

assign outIntDataOutRegWr = (regCounter == 8'd14) ? 1'b1 : 1'b0;

assign outBusy = (regCounter == 8'd0) ? 1'b0 : 1'b1;

endmodule