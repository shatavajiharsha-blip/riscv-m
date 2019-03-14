module tb_reg;
reg clk;
reg [4:0]rs1;
reg [4:0]rs2;
reg [4:0]rd;
reg rs1_rd_en;
reg rs2_rd_en;
reg rd_wd_en;
reg [31:0]rD;
wire [31:0]rS1;
wire [31:0]rS2;

register_file uut(
.clk(clk),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.rs1_rd_en(rs1_rd_en),
.rs2_rd_en(rs2_rd_en),
.rd_wd_en(rd_wd_en),
.rD(rD),
.rS1(rS1),
.rS2(rS2)
);

always #5 clk=~clk;

initial
begin
clk=0;
rs1=5'b1;
rs2=5'b10;
rd=5'b11;
rd_wd_en=1'b1;
rs1_rd_en=1'b1;
rs2_rd_en=1'b1;
rD=32'b10101;
end

initial 
begin
$shm_open("wave.shm");
$shm_probe("ACTMF");
#200;
$finish;
end

endmodule

