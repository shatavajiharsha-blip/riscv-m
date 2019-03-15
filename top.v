module top_module(
input clk,
input rst,
input en

);

//output [31:0]inst_out
//);

wire [31:0]w1;
wire [31:0]w2;
wire w3;
wire w4;
wire w5;
wire [4:0]w6;
wire [4:0]w7;
wire [4:0]w8;
wire [31:0]data1;
wire [31:0]data2;
wire e1;
wire e2;
wire e3;
wire e4;
wire e5;
wire e6;
wire e7;
wire e8;
wire e9;
wire e10;
wire e11;
wire e12;
wire e13;
wire e14;
wire e15;
wire e16;
wire e17;
wire e18;
wire e19;
wire e20;
wire e21;
wire e22;
wire e23;
wire e24;
wire e25;
wire e26;
wire e27;
wire e28;
wire e29;
wire e30;
wire e31;
wire [31:0]result;
wire [31:0]i;
wire [31:0]s;
wire [31:0]u;
//wire [31:0]pc;
wire [4:0]shift;
//wire e2;
//wire e2;




pc uut(
  .clk(clk),
  .rst(rst),
  .en(en),
  .inst_addr(w1)
);

im uut1(
  .address(w1),
  .en(en),
  .inst_out(w2)
);


CU uut2(
  .instruct(w2),
  .MUL_en(e1),
  .MULH_en(e2),
  .MULHSU_en(e3),
  .MULHU_en(e4),
  .DIV_en(e5),
  .DIVU_en(e6),
  .REM_en(e7),
  .REMU_en(e8),
  .ADD_en(e9),
  .SUB_en(e10),
  .AND_en(e11),
  .OR_en(e12),
  .XOR_en(e13),
  .SLL_en(e14),
  .SRL_en(e15),
  .SRA_en(e16),
  .SLT_en(e17),
  .ADDI_en(e18),
  .ANDI_en(e19),
  .ORI_en(e20),
  .XORI_en(e21),
  .SLTI_en(e22),
  .SLTIU_en(e23),
  .SLLI_en(e24),
  .SRLI_en(e25),
  .SRAI_en(e26),
  .SW_en(e27),
  .SH_en(e28),
  .SB_en(e29),
  .LUI_en(e30),
  .AUIPC_en(e31),
  .rs1_rd_en(w3),
  .rs2_rd_en(w4),
  .rd_wr_en(w5),
  .rs1(w6),
  .rs2(w7),
  .rd(w8),
  .shift_amount(shift),
  .IM_32_I(i),
  .IM_32_S(s),
  .IM_32_U(u)
);

register_file uut3(
.clk(clk),
.rs1(w6),
.rs2(w7),
.rd(w8),
.rs1_rd_en(w3),
.rs2_rd_en(w4),
.rd_wd_en(w5),
.rD(result),
.rS1(data1),
.rS2(data2)
);

alu uut4(
        .RS1(data1),
        .RS2(data2),
        .mul_en(e1), 
        .mulh_en(e2),
        .mulhsu_en(e3), 
        .mulhu_en(e4),
        .div_en(e5), 
        .divu_en(e6),
        .rem_en(e7), 
        .remu_en(e8),
        .add_en(e9), 
        .sub_en(e10),
        .and_en(e11), 
        .or_en(e12), 
        .xor_en(e13),
        .sll_en(e14), 
        .srl_en(e15), 
        .sra_en(e16),
        .slt_en(e17),
        .addi_en(e18), 
        .andi_en(e19),
        .ori_en(e20), 
        .xori_en(e21),
        .slti_en(e22), 
        .sltiu_en(e23),
        .slli_en(e24), 
        .srli_en(e25), 
        .srai_en(e26),
        .sw_en(e27), 
        .sh_en(e28), 
        .sb_en(e29),
        .lui_en(e30), 
        .auipc_en(e31),
        .IM_32_I(i), 
        .IM_32_S(s), 
        .IM_32_U(u),
        .shift_amount(shift),
        .PC(w1),
        .alu_out(result),
        .neg_flag(neg_flag)
    );



endmodule
