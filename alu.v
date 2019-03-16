module alu(
  input [31:0]RS1,
  input [31:0]RS2,
  input mul_en,
  input mulh_en,
  input mulhsu_en,
  input mulhu_en,
  input div_en,
  input divu_en,
  input rem_en,
  input remu_en,
  input add_en,
  input sub_en,
  input and_en,
  input or_en,
  input xor_en,
  input sll_en,
  input srl_en,
  input sra_en,
  input slt_en,
  input addi_en,
  input andi_en,
  input ori_en,
  input xori_en,
  input slti_en,
  input sltiu_en,
  input slli_en,
  input srli_en,
  input srai_en,
  input sw_en,
  input sh_en,
  input sb_en,
  input lui_en,
  input auipc_en,
  input [31:0]PC,
  input [4:0]shift_amount,
  input [31:0]IM_32_I,
  input [31:0]IM_32_S,
  input [31:0]IM_32_U,

  output neg_flag,
  output reg [31:0]alu_out
);
 
wire signed [31:0] SRS1=RS1;
wire signed [31:0] SRS2=RS2;
wire [63:0]s_product=SRS1*SRS2;
wire [63:0]su_product=SRS1*$unsigned(RS2);
wire [63:0]u_product = RS1*RS2;




always @ (*)
begin
  case({mul_en,mulh_en,mulhsu_en,mulhu_en,div_en,divu_en,rem_en,remu_en,add_en,sub_en,and_en,or_en,xor_en,sll_en,srl_en,sra_en,slt_en,addi_en,andi_en,ori_en,xori_en,slti_en,sltiu_en,slli_en,srli_en,srai_en,sw_en,sh_en,sb_en,lui_en,auipc_en})
  31'b10000000_00000000_00000000_0000000:alu_out=s_product[31:0];//MUL
  31'b01000000_00000000_00000000_0000000:alu_out=s_product[63:32];//MULH
  31'b00100000_00000000_00000000_0000000:alu_out=su_product[63:32];//MULHSU
  31'b00010000_00000000_00000000_0000000:alu_out=u_product[63:32];//MULHU
  31'b00001000_00000000_00000000_0000000:alu_out=SRS1/SRS2;//DIV
  31'b00000100_00000000_00000000_0000000:alu_out=RS1/RS2;//DIVU
  31'b00000010_00000000_00000000_0000000:alu_out=SRS1%SRS2;//REM
  31'b00000001_00000000_00000000_0000000:alu_out=RS1%RS2;//REMU
  31'b00000000_10000000_00000000_0000000:alu_out=RS1+RS2;//ADD
  31'b00000000_01000000_00000000_0000000:alu_out=RS1-RS2;//SUB
  31'b00000000_00100000_00000000_0000000:alu_out=RS1&RS2;//AND
  31'b00000000_00010000_00000000_0000000:alu_out=RS1|RS2;//OR
  31'b00000000_00001000_00000000_0000000:alu_out=RS1^RS2;//XOR
  31'b00000000_00000100_00000000_0000000:alu_out=RS1<<RS2;//SLL
  31'b00000000_00000010_00000000_0000000:alu_out=RS1>>RS2;//SRL
  31'b00000000_00000001_00000000_0000000:alu_out=SRS1>>>RS2;//SRA
  31'b00000000_00000000_10000000_0000000:alu_out=(SRS1<SRS2)?32'b1:32'b0;//SLT
  31'b00000000_00000000_01000000_0000000:alu_out=RS1+IM_32_I;//ADDI
  31'b00000000_00000000_00100000_0000000:alu_out=RS1&IM_32_I;//ANDI
  31'b00000000_00000000_00010000_0000000:alu_out=RS1|IM_32_I;//ORI
  31'b00000000_00000000_00001000_0000000:alu_out=RS1^IM_32_I;//XORI
  31'b00000000_00000000_00000100_0000000:alu_out=(SRS1<($signed(IM_32_I)))?1:0;//SLTI
  31'b00000000_00000000_00000010_0000000:alu_out=(RS1<IM_32_I)?1:0;//SLTIU
  31'b00000000_00000000_00000001_0000000:alu_out=RS1<<IM_32_I;//SLLI
  31'b00000000_00000000_00000000_1000000:alu_out=RS1>>shift_amount;//SRLI
  31'b00000000_00000000_00000000_0100000:alu_out=RS1>>>shift_amount;//SRAI
  31'b00000000_00000000_00000000_0010000:alu_out=RS1+IM_32_S;//SW
  31'b00000000_00000000_00000000_0001000:alu_out=RS1+IM_32_S;//SH
  31'b00000000_00000000_00000000_0000100:alu_out=RS1+IM_32_S;//SB
  31'b00000000_00000000_00000000_0000010:alu_out=IM_32_U<<12;//LUI
  31'b00000000_00000000_00000000_0000001:alu_out=PC+(IM_32_U<<12);//AUIPC



  default:alu_out=32'b0;
  endcase
end

assign neg_flag = alu_out[31]? 1'b1: 1'b0;
endmodule





