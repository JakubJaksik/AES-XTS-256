module AesXtsBlockOperation (
input	wire			inClk,
input	wire			inAesMode,
input	wire			inKeyWr,
input	wire [511:0]	inKeyData,
input	wire			inDataWr,
input	wire [127:0]	inDataData,
input	wire			inTweakValueWr,
input	wire [127:0]	inTweakValueData,
input	wire			inBlockNrWr,
input	wire [127:0]	inBlockNrData,
output	wire [127:0]	outData,
output	wire			outKeysReady,
output	wire			outBusy
);

wire			wireAesControloutIntKeyRegWr;
wire			wireAesControloutIntKeyRegAddr;
wire			wireAesControloutIntKeySchWr;
wire			wireAesBlockKeySchoutBusy;
wire 			wireAesControloutIntKeyMem1Wr;
wire 			wireAesControloutIntKeyMem1Rd;
wire 			wireAesControloutIntKeyMem2Wr;
wire 			wireAesControloutIntKeyMem2Rd;
wire			wireAesControloutIntAesBlockTweakValueRegWr;
wire			wireAesControloutIntAesEncDataWr;
wire 			wireAesEncoutBusy;
wire 			wireAesControloutIntAesBlockBlockNrReg
wire			wireAesControloutIntTValueRegWr;
wire 			wireAesControloutIntAesEncDecAesMode;
wire			wireAesControloutIntAesEncDecDataWr;
wire 			wireAesEncDecoutBusy;
wire			wireAesControloutIntDataOutRegWr;

wire [255:0]	wireAesBlockKeyRegoutKey;
wire [255:0]	wireAesBlockKeySchoutRoundKey;
wire [3:0]		wireAesControloutIntKeyMem1Addr;
wire [255:0]	wireAesBlockKeyMem1outData;
wire [3:0]		wireAesControloutIntKeyMem2Addr;
wire [255:0]	wireAesBlockKeyMem2outData;
wire [127:0]	wireAesBlockTweakValueRegoutData;
wire [127:0]	wireAesEncoutData;
wire [127:0]	wireAesBlockBlockNroutData;
wire [127:0]	wireAesBlockMultAlphaFunoutData;
wire [127:0]	wireAesTValueRegoutData;
wire [127:0]	wireAesBlockXor1FunoutData;
wire [127:0]	wireAesEncDecoutData;
wire [127:0]	wireAesBlockXor2FunoutData;

AesBlockControl AesBlockControl(
			.inClk(inClk),
			.inExtAesMode(inAesMode),
			.inExtKeyWr(inKeyWr),
			.inExtDataWr(inDataWr),
			.inExtTweakValueWr(inTweakValueWr),
			.inExtBlockNrWr(inBlockNrWr),
			.inIntKeySchBusy(wireAesBlockKeySchoutBusy),
			.inIntAesEncBusy(wireAesEncoutBusy),
			.inIntAesEncDecBusy(wireAesEncDecoutBusy),
			.outIntKeyRegWr(wireAesControloutIntKeyRegWr),
			.outIntKeyRegAddr(wireAesControloutIntKeyRegAddr),
			.outIntKeySchWr(wireAesControloutIntKeySchWr),
			.outIntKeyMem1Wr(wireAesControloutIntKeyMem1Wr),
			.outIntKeyMem1Rd(wireAesControloutIntKeyMem1Rd),
			.outIntKeyMem1Addr(wireAesControloutIntKeyMem1Addr),
			.outIntKeyMem2Wr(wireAesControloutIntKeyMem2Wr),
			.outIntKeyMem2Rd(wireAesControloutIntKeyMem2Rd),
			.outIntKeyMem2Addr(wireAesControloutIntKeyMem2Addr),
			.outIntAesBlockTweakValueRegWr(wireAesControloutIntAesBlockTweakValueRegWr);
			.outIntAesEncDataWr(wireAesControloutIntAesEncDataWr),
			.outIntAesBlockBlockNrReg(wireAesControloutIntAesBlockBlockNrReg),
			.outIntTValueRegWr(wireAesControloutIntTValueRegWr),
			.outIntAesEncDecAesMode(wireAesControloutIntAesEncDecAesMode),
			.outIntAesEncDecDataWr(wireAesControloutIntAesEncDecDataWr),
			.outIntDataOutRegWr(wireAesControloutIntDataOutRegWr)
			.outBusy(outBusy));			
			
AesBlockKeyReg AesBlockKeyReg(											
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntKeyRegWr),
			.inKey(inKeyData),                                         
			.inAddr(wireAesControloutIntKeyRegAddr),                    
			.outKey(wireAesBlockKeyRegoutKey));                       

AesBlockKeySch AesBlockKeySch(                                          
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntKeySchWr),                    
			.inKey(wireAesBlockKeyRegoutKey),                     		
			.outRoundKey(wireAesBlockKeySchoutRoundKey),                        
			.outBusy(wireAesBlockKeySchoutBusy));                       

AesSimpleMem AesBlockKeyMem1(                                         	
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntKeyMem1Wr),                       
			.inRd(wireAesControloutIntKeyMem1Rd),                       
			.inAddr(wireAesControloutIntKeyMem1Addr),                   
			.inData(wireAesBlockKeySchoutRoundKey),                         
			.outData(wireAesBlockKeyMem1outData));                      

AesSimpleMem AesBlockKeyMem2(                                         	
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntKeyMem2Wr),                       
			.inRd(wireAesControloutIntKeyMem2Rd),                       
			.inAddr(wireAesControloutIntKeyMem2Addr),                   
			.inData(wireAesBlockKeySchoutRoundKey),                     
			.outData(wireAesBlockKeyMem2outData));			            

AesSimpleReg AesBlockTweakValueReg(                                     
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntAesBlockTweakValueRegWr),                                                    
			.inData(inTweakValueData),
			.outData(wireAesBlockTweakValueRegoutData));                

AesBlockEnc AesBlockEnc(                                                
			.inClk(inClk),                                              
			.inKeyData(wireAesBlockKeyMem1outData),                     
			.inDataWr(wireAesControloutIntAesEncDataWr),          		
			.inDataData(wireAesBlockTweakValueRegoutData),              
			.outData(wireAesEncoutData),                                
			.outBusy(wireAesEncoutBusy));                               

AesSimpleReg AesBlockBlockNrReg(                  
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntAesBlockBlockNrReg),              
			.inData(inBlockNrData),										
			.outData(wireAesBlockBlockNroutData));

AesBlockMultAlphaFun AesBlockMultAlphaFun(                              
			.inBlockNr(wireAesBlockBlockNroutData),                    	
			.inTValue(wireAesEncoutData),                           	
			.outData(wireAesBlockMultAlphaFunoutData));                 

AesSimpleReg AesBlockTValueReg(                                         
			.inClk(inClk),                                              
			.inWr(wireAesControloutIntTValueRegWr),                     
			.inData(wireAesBlockMultAlphaFunoutData),                   
			.outData(wireAesTValueRegoutData));                         

AesXorFun AesBlockXor1(                                                 
			.inData0(wireAesTValueRegoutData),                          
			.inData(inDataData),                                        
			.outData(wireAesBlockXor1FunoutData));                      																		

AesBlockEncDec AesBlockEncDec(                                          
			.inClk(inClk),                                              
			.inAesMode(wireAesControloutIntAesEncDecAesMode),
			.inKeyData(wireAesBlockKeyMem2outData),                     
			.inDataWr(wireAesControloutIntAesEncDecDataWr),             
			.inDataData(wireAesBlockXor1FunoutData),                    
			.outData(wireAesEncDecoutData),                             
			.outBusy(wireAesEncDecoutBusy));                            

AesXorFun AesBlockXor2(                                                 
			.inData0(wireAesTValueRegoutData),                         
			.inData1(wireAesEncDecoutData),                              
			.outData(wireAesBlockXor2FunoutData));                      

AesSimpleReg AesBlockOutReg(                                           
			.inClk(inClk),
			.inWr(wireAesControloutIntDataOutRegWr),
			.inData(wireAesBlockXor2FunoutData),
			.outData(outData));