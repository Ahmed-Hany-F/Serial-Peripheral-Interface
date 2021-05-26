`include "Master.v"
module Master_tb ();

//inputs
reg clk; 
reg reset; 
reg start;
reg  MISO;
reg [1:0] slaveSelect;
reg [7:0] masterDataToSend;

//outputs
wire [7:0] masterDataReceived;
wire SCLK; 
wire [0:2]CS; 
wire MOSI;

// Calling the module
Master UUT(
clk,
reset,
start,
slaveSelect,
masterDataToSend,
masterDataReceived,
SCLK,
CS,
MOSI,
MISO);

//period of 10
localparam period = 10;

// Data sent to Master
reg [7:0] Data_sent;

always@(posedge SCLK)
	begin
    	MISO = Data_sent[0];
	Data_sent = Data_sent>>1;
	end

always@(negedge SCLK) 
	begin	
	Data_sent[7] = MOSI;
	end

// Main clk in the module
always begin
#(period/2) clk = ~clk;
end

//counter
integer i;

initial begin

slaveSelect = 1;
i = 0;
clk = 0;
start = 0;
reset = 1;
#(period/16) reset = 0;

//first test case
	masterDataToSend = 8'b00000001;
	Data_sent = 8'b00000010;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	// period * 9 ->  8 period to shift + 1 period to be able to asssign the last bit
	#(period*9);
	if (Data_sent == 8'b00000001) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00000010) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
	
//Second test case
	masterDataToSend = 8'b11111111;
	Data_sent = 8'b00000000;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b11111111) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00000000) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//third test case
	masterDataToSend = 8'b00001111;
	Data_sent = 8'b11110000;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b00001111) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b11110000) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//forth test case
	masterDataToSend = 8'b00110001;
	Data_sent = 8'b00011010;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b00110001) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00011010) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//fifth test case
	masterDataToSend = 8'b11000001;
	Data_sent = 8'b00001110;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b11000001) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00001110) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//6th test case
	masterDataToSend = 8'b00111001;
	Data_sent = 8'b11000110;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b00111001) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b11000110) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//7th test case
	masterDataToSend = 8'b00000111;
	Data_sent = 8'b00000010;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b00000111) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00000010) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//8th test case
	masterDataToSend = 8'b00000001;
	Data_sent = 8'b00111110;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b00000001) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00111110) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//9th test case
	masterDataToSend = 8'b11000001;
	Data_sent = 8'b00000010;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b11000001) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b00000010) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end
//10th test case
	masterDataToSend = 8'b00000000;
	Data_sent = 8'b11111111;
	#(period/16)start = 1;
	#(period/16)start = 0;
	//checking
	i = i+1;
	$display(i);
	#(period*9);
	if (Data_sent == 8'b00000000) begin
		$display("Success in Sending");
	end
	else begin
		$display("Failed in Sending");
	end
	if (masterDataReceived == 8'b11111111) begin
		$display("Success in Receiving");
	end
	else begin
		$display("Failed in Receiving");
	end

#(period/2) $finish;
end

endmodule
