module testbench;
  reg clk, reset, write, read;
  reg [15:0] d, data;
  reg [3:0] address, read1, read2;
  wire [15:0] value1, value2;

  st_bit DUT (
      .clk(clk),
      .address(address),
      .reset(reset),
      .data(data),
      .read1(read1),
      .read2(read2),
      .value1(value1),
      .value2(value2),
      .write(write),
      .read(read)
  );

  always #1 clk = ~clk;

  initial begin
    $monitor(
        $time,
        "clk=%b,reset=%b,write=%b,address=%b,data=%b,read=%b,read1=%b,read2=%b,value1=%b,value2=%b,reset=%b",
        clk, reset, write, address, data, read, read1, read2, value1, value2, reset);

    //inputs to the module

    clk <= 0;
    write <= 1'b0;
    address <= 4'b0;
    read <= 1'b1;
    read1 <= 4'b0;
    read2 <= 4'b0;
    data <= 16'b0;
    reset <= 1'b0;

    #5 write <= 1'b1;
    address <= 4'd0;
    data <= 16'd10;
    read <= 1'b1;
    read1 <= 4'b0;
    read2 <= 4'b0;
    reset <= 1'b0;

    #10 write <= 1'b1;
    address <= 4'd3;
    data <= 16'd10;
    read <= 1'b1;
    read1 <= 4'b0;
    read2 <= 4'd3;
    reset <= 1'b0;

    #10 write <= 1'b1;
    address <= 4'd3;
    data <= 16'd7;
    read <= 1'b1;
    read1 <= 4'b0;
    read2 <= 4'd3;
    reset <= 1'b0;

    #10 write <= 1'b0;
    address <= 4'd3;
    data <= 16'd7;
    read <= 1'b1;
    read1 <= 4'd3;
    read2 <= 4'd3;
    reset <= 1'b0;


    #100 $finish;

  end

  initial begin
    $dumpfile("16_bit.vcd");
    $dumpvars;
  end
endmodule
