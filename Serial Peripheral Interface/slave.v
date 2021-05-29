module Slave(reset, initialValue, slaveDataToSend, clk, cs, MOSI, MISO );
  
// Inputs & outputs //
  input reset;
  input [7:0] initialValue;
  output reg [7:0] slaveDataToSend;
  input clk;
  input cs;
  input MOSI;
  output reg MISO;

  //resvoir for the data
  reg [7:0] dataRegistered; 
  //temp resovoir for the data to be shifted & sent
  reg [7:0] tempDataRegistered; 

  wire CPHA=1;
  wire CPOL =0;
  // for reassigning temp resovoir to data be shifted & sent again
  always@(cs)
  begin
  tempDataRegistered = dataRegistered;
  end

  always @(reset) begin
    if (reset == 1) begin
      dataRegistered = 0;
      slaveDataToSend = 0;
      tempDataRegistered = 0;
      end
  end
  
  always @(initialValue) begin
    dataRegistered = initialValue;
    slaveDataToSend = dataRegistered;
    tempDataRegistered = dataRegistered;
  end
  
  
  // At rising edge shift - sent//
  always @(posedge clk)
  begin
  if(cs == 0)
  begin
      MISO = tempDataRegistered[0];
      tempDataRegistered = tempDataRegistered>>1;
  end
  else 
   MISO = 1'bz;
  end
  
  // At falling adge sampling - recieved //
  always @(negedge clk) begin 
  if(cs == 0)
  begin
    tempDataRegistered[7]=MOSI;
    slaveDataToSend = tempDataRegistered;
  end
  end

endmodule
