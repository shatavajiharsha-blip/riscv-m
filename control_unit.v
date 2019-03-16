module CU(
input [31:0]instruct,

output reg MUL_en,
output reg MULH_en,
output reg MULHSU_en,
output reg MULHU_en,
output reg DIV_en,
output reg DIVU_en,
output reg REM_en,
output reg REMU_en,
output reg ADD_en,
output reg SUB_en,
output reg AND_en,
output reg OR_en,
output reg XOR_en,
output reg SLL_en,
output reg SRL_en,
output reg SRA_en,
output reg SLT_en,
output reg ADDI_en,
output reg ANDI_en,
output reg ORI_en,
output reg XORI_en,
output reg SLTI_en,
output reg SLTIU_en,
output reg SLLI_en,
output reg SRLI_en,
output reg SRAI_en,
output reg SW_en,
output reg SH_en,
output reg SB_en,
output reg LUI_en,
output reg AUIPC_en,
output reg rs1_rd_en,
output reg rs2_rd_en,
output reg rd_wr_en,
output reg [4:0]rs1,
output reg [4:0]rs2,
output reg [4:0]rd,
output [31:0]IM_32_I,
output [31:0]IM_32_S,
output reg [4:0]shift_amount,
output [31:0]IM_32_U
);

wire [6:0]opcode;
wire [2:0]func3;
wire [6:0]func7;
wire [11:0]imm_12;

reg [11:0]im_i;
reg [11:0]im_s;
reg [20:0]im_u;

assign opcode=instruct[6:0];
assign func3=instruct[14:12];
assign func7=instruct[31:25];
//assign imm_12=instruct[31:20];


always@(*)
begin
MUL_en=1'b0;
MULH_en=1'b0;
MULHSU_en=1'b0;
MULHU_en=1'b0;
DIV_en=1'b0;
DIVU_en=1'b0;
REM_en=1'b0;
REMU_en=1'b0;
ADD_en=1'b0;
SUB_en=1'b0;
AND_en=1'b0;
OR_en=1'b0;
XOR_en=1'b0;
SLL_en=1'b0;
SRL_en=1'b0;
SRA_en=1'b0;
SLT_en=1'b0;
ADDI_en=1'b0;
ANDI_en=1'b0;
ORI_en=1'b0;
XORI_en=1'b0;
SLTI_en=1'b0;
SLTIU_en=1'b0;
SLLI_en=1'b0;
SRLI_en=1'b0;
SRAI_en=1'b0;
SW_en=1'b0;
SH_en=1'b0;
SB_en=1'b0;
LUI_en=1'b0;
AUIPC_en=1'b0;


rs1_rd_en = 1'b0;
rs2_rd_en = 1'b0;
rd_wr_en = 1'b0;


case (opcode)
  7'b0110011:
  begin
    rs1=instruct[19:15];
    rs2=instruct[24:20];
    rd=instruct[11:7];
    rs1_rd_en=1'b1;
    rs2_rd_en=1'b1;
    rd_wr_en=1'b1;

    case({func7,func3})
    //R TYPE
    {10'b0000001_000}:MUL_en=1'b1;//MUL
    {10'b0000001_001}:MULH_en=1'b1;//MULH
    {10'b0000001_010}:MULHSU_en=1'b1;//MULHSU
    {10'b0000001_011}:MULHU_en=1'b1;//MULHU
    {10'b0000001_100}:DIV_en=1'b1;//DIV
    {10'b0000001_101}:DIVU_en=1'b1;//DIVU
    {10'b0000001_110}:REM_en=1'b1;//REM
    {10'b0000001_111}:REMU_en=1'b1;//REMU
    {10'b0000000_000}:ADD_en=1'b1;//ADD
    {10'b0100000_000}:SUB_en=1'b1;//SUB
    {10'b0000000_111}:AND_en=1'b1;//AND
    {10'b0000000_110}:OR_en=1'b1;//OR
    {10'b0000000_100}:XOR_en=1'b1;//XOR
    {10'b0000000_001}:SLL_en=1'b1;//SLL
    {10'b0000000_101}:SRL_en=1'b1;//SRL
    {10'b0100000_101}:SRA_en=1'b1;//SRA
    {10'b0000000_010}:SLT_en=1'b1;//SLT
    default:;
    endcase

  end

  7'b0010011:
  begin
    rs1=instruct[19:15];
    im_i=instruct[31:20];
    rd=instruct[11:7];
    rs1_rd_en=1'b1;
    //rs2_rd_en=1'b0;
    rd_wr_en=1'b1;

   
    case({func7,func3})

    //I TYPE
    10'b0000000_000:ADDI_en=1'b1;//ADDI
    10'b0000000_111:ANDI_en=1'b1;//ANDI
    10'b0000000_110:ORI_en=1'b1;//ORI
    10'b0000000_100:XORI_en=1'b1;//XORI
    10'b0000000_010:SLTI_en=1'b1;//SLTI
    10'b0000000_011:SLTIU_en=1'b1;//SLTIU
    10'b0000000_001:SLLI_en=1'b1;//SLLI
    10'b0000000_101:
      begin
        rs1=instruct[19:15];
        rd=instruct[11:7];
        rs1_rd_en=1'b1;
        rd_wr_en=1'b1;
        shift_amount=instruct[24:20];
        SRLI_en=1'b1;//SRLI
      end
    10'b0100000_101:
      begin
        rs1=instruct[19:15];
        rd=instruct[11:7];
        rs1_rd_en=1'b1;
        rd_wr_en=1'b1;
        shift_amount=instruct[24:20];
        SRAI_en=1'b1;//SRAI
      end
    default:;
    endcase
      end

  7'b0100011:
  begin//S TYPE
    rs1=instruct[19:15];
    rs2=instruct[24:20];
    shift_amount=5'b0;
    im_s={instruct[31:25],instruct[11:7]};
    rs1_rd_en=1'b1;
    rs2_rd_en=1'b1;

    case(func3)
    3'b010:SW_en=1'b1;//SW
    3'b001:SH_en=1'b1;//SH
    3'b000:SB_en=1'b1;//SB
    default:;
    endcase
  end

//u type
  7'b0110111:
    begin
      im_u=instruct[31:12];
      rd=instruct[11:7];
      rd_wr_en=1'b1;
      LUI_en=1'b1;//LUI
    end
  7'b0010111:
    begin
      im_u=instruct[31:12];
      rd=instruct[11:7];
      rd_wr_en=1'b1;
      AUIPC_en=1'b1;//AUIPC
    end
endcase

end
assign IM_32_I={{20{im_i[11]}},im_i};
assign IM_32_S={{20{im_s[11]}},im_s};
assign IM_32_U={{12{im_u[19]}},im_u};



endmodule

