module im_tb;
reg [31:0]address;
reg en;
wire [31:0]inst_out;

im uut(
  .en(en),
  .address(address),
  .inst_out(inst_out)
);


initial begin
  en=0;
  #5;
  address=31'b1;
  en=1;
  address=32'd2;
#5;
  address=32'd3;
#5;
  address=32'd1;
#5;
  address=32'd11;
#5;
  address=32'd21;
#5;
  address=32'd31;
#5;
  address=32'd29;
#5;
  address=32'd12;
 #5;
  address=32'd25;
#5;
  address=32'd18;
  #5;
  address=32'd19;
#5;
  address=32'd5;


end

initial
begin
  $shm_open("wave.shm");
  $shm_probe("ACTMF");
  #100;
  $finish;
end

endmodule

