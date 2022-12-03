module AesBlockControl(
input	wire			inClk,
input	wire			inKeySchBusy,
input	wire			inExtKeyWr,
input	wire			inAesEncBusy,
input	wire			inAesEncDecBusy,
input	wire			inExtDataWr,
output	wire			outIntKeySchDataWr,		//
output	wire			outIntKeyRegRd,			//
output	wire			outIntKeyRegAddr,		//
output	wire			outIntKeyMem1Wr,		//
output	wire			outIntKeyMem1Addr,		//
output	wire			outIntKeyMem1Rd,		//
output	wire			outIntKeyMem2Wr,
output	wire			outIntKeyMem2Addr,
output	wire			outIntKeyMem2Rd,
output	wire			outIntAesEncDataWr,
output	wire			outIntAesEncDecDataWr,
output	wire			outIntDataOutRegWr
);

reg	regKey1Ready = 1'b0;
reg regKey2Ready = 1'b0;
reg regAesEncReady = 1'b0;

reg [7:0] regKey1Counter = 8'b0;
reg [7:0] regKey2Counter = 8'b0;
reg [7:0] regAesEncCounter = 8'b0;
reg [7:0] regAesEncDecCounter = 8'b0;

always @ (posedge(inClk))
begin
    if (inKeySchBusy == 1'b1 && regKey1Ready == 1'b0) begin
        regKey1Counter <= regKey1Counter + 8'd1;
    end
	
	if (regKey1Counter != 1'b0 && inKeySchBusy == 1'b0 && regKey1Ready == 1'b0) begin
		regKey1Ready <= 1'b1;
	end
end

always @ (posedge(inClk))
begin
    if (inKeySchBusy == 1'b1 && regKey1Ready == 1'b1 && regKey2Ready == 1'b0) begin
        regKey2Counter <= regKey2Counter + 8'd1;
    end
	
	if (regKey2Counter != 1'b0 && inKeySchBusy == 1'b0 && regKey1Ready == 1'b1) begin
		regKey2Ready <= 1'b1;
	end
end

always @ (posedge(inClk))
begin
	if (inAesEncBusy == 1'b1) begin
		regAesEncCounter <= regAesEncCounter + 8'd1;
	end
	
	if (regAesEncCounter != 8'd0 && inAesEncBusy == 1'b0) begin 
		regAesEncReady <= 1'b1;
	end
end

always @ (posedge(inClk))
begin
	if (inAesEncDecBusy == 1'b1) begin
		regAesEncDecCounter <= regAesEncDecCounter + 8'd1;
	end
	
	if (regAesEncDecCounter != 8'd0 && inAesEncDecBusy == 1'b0) begin 
		regKey1Ready 		<= 1'b0;
		regKey2Ready 		<= 1'b0;
		regAesEncReady 		<= 1'b0;
		regKey1Counter 		<= 8'd0;
		regKey2Counter 		<= 8'd0;
		regAesEncCounter 	<= 8'd0;
		regAesEncDecCounter	<= 8'd0;
	end
end

assign outIntKeySchDataWr = ((regKey1Counter == 1'b0 && inExtKeyWr == 1'b1) || (regKey1Ready == 1'b1 && regKey2Counter == 1'b0)) ? 1'b1 : 1'b0;
assign outIntKeyRegRd = ((regKey1Counter == 1'b0 && inExtKeyWr == 1'b1) || (regKey1Ready == 1'b1 && regKey2Counter == 1'b0)) ? 1'b1 : 1'b0;
assign outIntKeyRegAddr = (regKey1Counter == 1'b0 && inExtKeyWr == 1'b1) ? 1'b0 : (regKey1Ready == 1'b1 && regKey2Counter == 1'b0);
assign outIntKeyMem1Wr = (regKey1Counter != 1'b0 && regKey1Ready == 1'b0) ? 1'b1 : 1'b0;
assign outIntKeyMem1Addr = (regKey1Counter != 1'b0 && regKey1Ready == 1'b0) ? regKey1Counter : ((regAesEncCounter != 1'b0 && regAesEncReady == 1'b0) ? regAesEncCounter : 4'b0);
assign outIntKeyMem1Rd = (regAesEncReady == 1'b1) ? 1'b0 : regAesEncCounter;
assign 










reg regBusy = 1'b0;



always @ (posedge(inClk))
begin
	if (inExtKeyWr == 1'b0 && regBusy == 1'b0) begin
		regBusy <= 1'b1;
	end
	
	if (regBusy == 1'b1 && inKeySchBusy == 1'b0 && regKey1Ready == 1'b0) begin
		regKey1Ready <= 1'b1;
		
	if (regBusy == 1'b1 && inKeySchBusy == 1'b0 && regKey1Ready == 1'b1 && regKey1Ready == 1'b0) begin // chyba zmieni w złym momencie
		regKey2Ready <= 1'b1;
	
end
	
	
	


// przychodzi klucz
// zaczynam wyznaczać klucze rundowe
// zaczynam 1 szyfrowanie i 2 wyznaczanie klucza
// zaczynam 2 szyfrowanie