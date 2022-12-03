module AesKeySchControl(
input	wire			inClk,
input	wire			inExtDataWr,
output	wire			outIntKeySchRegExtWr,
output	wire			outIntKeySchRegIntWr,
output	wire			outIntKeySchFunMode,
output	wire			outBusy
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


assign outIntKeySchRegExtWr = (regCounter == 8'b0) ? inExtDataWr : 1'b0;

assign outIntKeySchRegIntWr = (regCounter == 8'b0) ? 1'b0 : 1'b1;

assign outIntKeySchFunMode = regCounter[0];

assign outBusy = (regCounter == 8'd0) ? 1'b0 : 1'b1;

endmodule