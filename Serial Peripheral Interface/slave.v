module SLAVE(reset, initialValue, slaveDataToSend, clk, cs, MOSI, MISO );
  
// Inputs & outputs //
  input reset;
  input [7:0] initialValue;
  output reg [7:0] slaveDataToSend;
  input clk;
  input cs;
  input MOSI;
  output reg MISO;
  
  
  reg [7:0] dataRegistered; 
  wire CPHA=1;
  wire CPOL =0;

  always @(reset) begin
    if (reset == 1) begin
      dataRegistered = 0;
      slaveDataToSend = 0;
      end
  end
  
  always @(initialValue) begin
    dataRegistered = initialValue;
    slaveDataToSend = dataRegistered;
  end
  
  
  // At rising edge shift - sent//
  always @(posedge clk)
  begin
  if(cs == 0)
  begin
      MISO = dataRegistered[0];
      dataRegistered = dataRegistered>>1;
  end
  end
  
  // At falling adge sampling - recieved //
  always @(negedge clk) begin 
     if(cs == 0)
  begin
    dataRegistered[7]=MOSI;
    slaveDataToSend = dataRegistered;
  end
  end

endmodule
