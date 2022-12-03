module AesXtsBlockOperation (
input	wire			inClk,
input	wire			inAesMode,
input	wire			inKeyWr,
input	wire			inDataWr,
input	wire			inTweakValueWr,
input	wire			inBlockNrWr,
input	wire [127:0]	inDataData,
input	wire [511:0]	inKeyData,
input	wire [127:0]	inTweakValueData,
input	wire [127:0]	inBlockNrData,
output	wire [127:0]	outData,
output	wire			outKeysReady,
output	wire			outBusy
);

reg [7:0] regCounterKey = 8'b0;
reg [7:0] regCounterData = 8'b0;

always @ (posedge(inClk))
begin
    if ((inKeyWr == 1'b1) || (regCounterKey != 8'b0)) begin
        if ((inKeyWr == 1'b1) && (regCounterKey == 8'd5)) begin
            regCounterKey <= 8'b0;
        end else begin
            regCounterKey <= regCounterKey + 8'd1;
        end
    end
	
	if ((inDataWr == 1'b1) || (regCounterData != 8'b0)) begin
        if (regCounterData == 8'd5) begin
            regCounterData <= 8'b0;
        end else begin
            regCounterData <= regCounterData + 8'd1;
        end
    end
end

assign outData = inDataData;
assign outKeysReady = (regCounterKey == 8'd5) ? 1'b1 : 1'b0;
assign outBusy = (((regCounterKey == 8'd0) || (regCounterData == 8'd5)) || (regCounterData == 8'd0)) ? 1'b0 : 1'b1;

endmodule
