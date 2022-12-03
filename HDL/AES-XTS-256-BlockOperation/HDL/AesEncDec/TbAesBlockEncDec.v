module TbAesEncDec;

/////////////////////////////////////////

parameter inClkp = 10;
reg         inClk         = 1'b0;

always
begin
    #(inClkp/2) inClk = !inClk;
end

/////////////////////////////////////////

reg					inKeyWr		= 1'b0;
reg					inAesMode	= 1'b1;
reg		[127:0]		inKeyData0	= 128'b0;
reg		[127:0]		inKeyData1	= 128'b0;
reg					inDataWr	= 1'b0;
reg		[127:0]		inDataData  = 128'b0;
wire 	[127:0]		outData;
wire				outBusy;

reg	[255:0]	tempKey  = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
reg	[127:0]	tempData = 128'h8ea2b7ca516745bfeafc49904b496089;

AesBlockEncDec aesBlockEncDec(
    .inClk(inClk),
	.inAesMode(inAesMode),
    .inKeyData0(inKeyData0),
	.inKeyData1(inKeyData1),
    .inDataWr(inDataWr),
    .inDataData(inDataData),
    .outData(outData),
    .outBusy(outBusy));

always
begin
	
	inDataWr 	= 1'b1; inDataData <= tempData;
	#(inClkp/2);
	inKeyData0 = 128'h24fc79ccbf0979e9371ac23c6d68de36;
	inKeyData1 = 128'h4e5a6699a9f24fe07e572baacdf8cdea;
	#(inClkp + 1);
	// Bez tego +1 się psuło bo szybciej zmieniał się klucz
	// możliwe że jak to będzie sterowane z zewnątrz to będzie git ale trzeba pomyśle
	// Do roundReg zamiast wyjścia z fullRound to było przypisywane jakieś gówno
	
	// chyba trzeba dodać rejest klucza
    inKeyData0 = 128'h2541fe719bf500258813bbd55a721c0a;
	inKeyData1 = 128'b0;
	inDataWr 	= 1'b0; inDataData <= 128'b0;
	#(inClkp);
    inKeyData0 = 128'hf01afafee7a82979d7a5644ab3afe640;
	#(inClkp);
    inKeyData0 = 128'h7ccff71cbeb4fe5413e6bbf0d261a7df;
	#(inClkp);
    inKeyData0 = 128'h45f5a66017b2d387300d4d33640a820a;
	#(inClkp);
    inKeyData0 = 128'h0bdc905fc27b0948ad5245a4c1871c2f;
	#(inClkp);
    inKeyData0 = 128'h3de23a75524775e727bf9eb45407cf39;
	#(inClkp);
    inKeyData0 = 128'hc656827fc9a799176f294cec6cd5598b;
	#(inClkp);
    inKeyData0 = 128'h6de1f1486fa54f9275f8eb5373b8518d;
	#(inClkp);
    inKeyData0 = 128'hae87dff00ff11b68a68ed5fb03fc1567;
	#(inClkp);
	inKeyData0 = 128'h1651a8cd0244beda1a5da4c10640bade;
	#(inClkp);
	inKeyData0 = 128'ha573c29fa176c498a97fce93a572c09c;
	#(inClkp);
	inKeyData0 = 128'h101112131415161718191a1b1c1d1e1f;
	#(inClkp);
	inKeyData0 = 128'h000102030405060708090a0b0c0d0e0f;
	#(inClkp);
	inKeyData0 = 128'h0;
	inKeyData1 = 128'h0;
	wait(outBusy == 1'b0 && inClk == 1'b0);
	$stop;
end

endmodule

// Przy deszyfrowaniu niepoprawne przypisanie wyniku na wyjście