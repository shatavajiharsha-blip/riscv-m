module top_tb;
reg clk;
reg rst;
reg en;

//wire [31:0]inst_out;

top_module uut(
  .clk(clk),
  .rst(rst),
  .en(en)
);

  //.inst_out(inst_out)
//);

always #5 clk=~clk;
initial
begin
clk=0;
#5;
en=0;
rst=1;
#5;
en=1;
rst=0;
end

initial begin
  $shm_open("wave.shm");
  $shm_probe("ACTMF");
  #1000;
  $finish;
end

endmodule



