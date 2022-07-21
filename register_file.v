//register file with 16 D-flip flops (16 bit each)
module st_bit (
    input clk,
    input write,
    input read,
    input reset,
    input [3:0] address,  //address is the 4 bit location of the flip flop numbered from 0-15
    input [15:0] data,  //data to be stored in the given address of the flip flop 
    input [3:0] read1,  //read1 is the 4 bit location of the flip flop from which data is to be read
    input [3:0] read2,  //read2 is the 4 bit location of the flip flop from which data is to be read
    output reg [15:0] value1,  //value1 is the data stored in the flip flop location given by read1
    output reg [15:0] value2  //value2 is the data stored in the flip flop location given by read2
);

  reg [15:0] w[15:0];  //16x 16bit registers used for data read and write

  always @(negedge clk) begin  //write and reset block
    for (integer i = 0; i < 16; i++) begin

      if (reset == 1'b0) begin
        if (write > 1'b0 && address == i) begin
          w[i] <= data;
        end
      end else begin
        w[i] <= {16{1'b0}};
      end


    end
  end

  always @(*) begin  //read block
    if (read > 1'b0) begin
      value1 <= w[read1];
      value2 <= w[read2];
    end
  end

endmodule
