module tb;
reg [31:0]instruct;
wire MUL_en;
wire MULH_en;
wire MULHSU_en;
wire MULHU_en;
wire DIV_en;
wire DIVU_en;
wire REM_en;
wire REMU_en;
wire ADD_en;
wire SUB_en;
wire AND_en;
wire OR_en;
wire XOR_en;
wire SLL_en;
wire SRL_en;
wire SRA_en;
wire SLT_en;
wire ADDI_en;
wire ANDI_en;
wire ORI_en;
wire XORI_en;
wire SLTI_en;
wire SLTIU_en;
wire SLLI_en;
wire SRLI_en;
wire SRAI_en;
wire SW_en;
wire SH_en;
wire SB_en;
wire LUI_en;
wire AUIPC_en;
wire rs1_rd_en;
wire rs2_rd_en;
wire rd_wr_en;
wire [4:0]rs1;
wire [4:0]rs2;
wire [4:0]rd;
wire[4:0]shift_amount;
wire [31:0]IM_32_I;
wire [31:0]IM_32_S;
wire [31:0]IM_32_U;

CU uut(
  .instruct(instruct),
  .MUL_en(MUL_en),
  .MULH_en(MULH_en),
  .MULHSU_en(MULHSU_en),
  .MULHU_en(MULHU_en),
  .DIV_en(DIV_en),
  .DIVU_en(DIVU_en),
  .REM_en(REM_en),
  .REMU_en(REMU_en),
  .ADD_en(ADD_en),
  .SUB_en(SUB_en),
  .AND_en(AND_en),
  .OR_en(OR_en),
  .XOR_en(XOR_en),
  .SLL_en(SLL_en),
  .SRL_en(SRL_en),
  .SRA_en(SRA_en),
  .SLT_en(SLT_en),
  .ADDI_en(ADDI_en),
  .ANDI_en(ANDI_en),
  .ORI_en(ORI_en),
  .XORI_en(XORI_en),
  .SLTI_en(SLTI_en),
  .SLTIU_en(SLTIU_en),
  .SLLI_en(SLLI_en),
  .SRLI_en(SRLI_en),
  .SRAI_en(SRAI_en),
  .SW_en(SW_en),
  .SH_en(SH_en),
  .SB_en(SB_en),
  .LUI_en(LUI_en),
  .AUIPC_en(AUIPC_en),
  .rs1_rd_en(rs1_rd_en),
  .rs2_rd_en(rs2_rd_en),
  .rd_wr_en(rd_wr_en),
  .rs1(rs1),
  .rs2(rs2),
  .rd(rd),
  .shift_amount(shift_amount),
  .IM_32_I(IM_32_I),
  .IM_32_S(M_32_S),
  .IM_32_U(IM_32_U)
);

initial begin
  instruct= 32'b0000001_00001_00000_000_10101_0110011;//MUL
  #20;
  instruct= 32'b0000001_00001_00000_001_10101_0110011;//MULH
  #20;
  instruct= 32'b0000001_00001_00000_010_10101_0110011;//MULhSu
  #20;
  instruct = 32'b0000001_00001_00100_011_10101_0110011;//MULHU
  #20;
  instruct = 32'b0000001_00001_00000_100_10101_0110011;//DIV
  #20;
  instruct = 32'b0000001_00001_00000_101_10101_0110011;//DIVU
  #20;
  instruct = 32'b0000001_00001_00000_110_10101_0110011;//REM
  #20;
  instruct = 32'b0000001_00001_00000_111_00101_0110011;//REMU
  #20;
  instruct = 32'b0000000_00100_00011_000_00110_0110011;//ADD
  #20;
  instruct = 32'b0100000_00100_00011_000_00110_0110011;//SUB
  #20;
  instruct = 32'b0000000_00110_00101_111_00111_0110011;//AND
  #20;
  instruct = 32'b0000000_00010_00001_110_01000_0110011;//OR
  #20;
  instruct = 32'b0000000_00011_00010_100_01001_0110011;//XOR
  #20;
  instruct = 32'b0000000_00010_00001_001_01010_0110011;//SLL
  #20;
  instruct = 32'b0000000_00010_00001_101_01011_0110011;//SRL
  #20;
  instruct = 32'b0100000_00010_00001_101_01100_0110011;//SRA
  #20;
  instruct = 32'b0000000_00010_00001_010_01101_0110011;//SLT
  #20;


//I TYPE
  instruct = 32'b000000000011_00001_000_00001_0010011;//addi
#20;
  instruct = 32'b000000001000_00010_111_00010_0010011;//andi
#20;
  instruct = 32'b000000000001_00011_110_00011_0010011;//ori
#20;
  instruct = 32'b000000000010_00100_100_00100_0010011;//xori
#20;
  instruct = 32'b000000000101_00010_010_01001_0010011;//SLTI
#20;
  instruct = 32'b000000000101_00010_011_01001_0010011;//SLTIU
#20;
  instruct = 32'b000000000010_00001_001_01011_0010011;//SLLI
#20;
  instruct = 32'b0000000_00011_00001_101_01100_0010011;//SRLI
#20;
  instruct = 32'b0100000_00100_00001_101_01101_0010011;//SRAI
#20;


//S TYPE
  instruct = 32'b0000000_00110_00010_010_01100_0100011;//SW
#20;
  instruct = 32'b0000000_00111_00011_001_00100_0100011;//SH
#20;
  instruct = 32'b0000000_01000_00100_000_00000_0100011;//SB
#20;


//U TYPE
  instruct = 32'b000010010001101000101_01010_0110111;//LUI
#20;
  instruct = 32'b000010010001101000101_01010_0010111;//AUIPC


end

initial begin
  $shm_open("wave.shm");
  $shm_probe("ACTMF");
  #1000;
  $finish;
end
endmodule
  





