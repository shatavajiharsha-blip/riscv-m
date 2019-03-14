module alu_tb;

    // --------------------------
    // DUT Inputs
    // --------------------------
    reg  [31:0] RS1, RS2;
    reg  [31:0] IM_32_I, IM_32_S, IM_32_U;
    reg  [31:0] PC;
    reg  [4:0]  shift_amount;

    reg mul_en, mulh_en, mulhsu_en, mulhu_en;
    reg div_en, divu_en, rem_en, remu_en;

    reg add_en, sub_en, and_en, or_en, xor_en;
    reg sll_en, srl_en, sra_en, slt_en;

    reg addi_en, andi_en, ori_en, xori_en;
    reg slti_en, sltiu_en;
    reg slli_en, srli_en, srai_en;

    reg sw_en, sh_en, sb_en;
    reg lui_en, auipc_en;

    wire [31:0] alu_out;
    wire neg_flag;

    // --------------------------
    // Instantiate DUT
    // --------------------------
    alu DUT(
        .RS1(RS1), .RS2(RS2),
        .mul_en(mul_en), .mulh_en(mulh_en),
        .mulhsu_en(mulhsu_en), .mulhu_en(mulhu_en),
        .div_en(div_en), .divu_en(divu_en),
        .rem_en(rem_en), .remu_en(remu_en),
        .add_en(add_en), .sub_en(sub_en),
        .and_en(and_en), .or_en(or_en), .xor_en(xor_en),
        .sll_en(sll_en), .srl_en(srl_en), .sra_en(sra_en),
        .slt_en(slt_en),
        .addi_en(addi_en), .andi_en(andi_en),
        .ori_en(ori_en), .xori_en(xori_en),
        .slti_en(slti_en), .sltiu_en(sltiu_en),
        .slli_en(slli_en), .srli_en(srli_en), .srai_en(srai_en),
        .sw_en(sw_en), .sh_en(sh_en), .sb_en(sb_en),
        .lui_en(lui_en), .auipc_en(auipc_en),
        .IM_32_I(IM_32_I), .IM_32_S(IM_32_S), .IM_32_U(IM_32_U),
        .shift_amount(shift_amount),
        .PC(PC),
        .alu_out(alu_out),
        .neg_flag(neg_flag)
    );

    // ---------------------------------
    // Utility tasks
    // ---------------------------------
    task reset_controls;
    begin
        mul_en=0; mulh_en=0; mulhsu_en=0; mulhu_en=0;
        div_en=0; divu_en=0; rem_en=0; remu_en=0;
        add_en=0; sub_en=0; and_en=0; or_en=0; xor_en=0;
        sll_en=0; srl_en=0; sra_en=0; slt_en=0; //sltu_en=0;

        addi_en=0; andi_en=0; ori_en=0; xori_en=0;
        slti_en=0; sltiu_en=0;

        slli_en=0; srli_en=0; srai_en=0;

        sw_en=0; sh_en=0; sb_en=0;
        lui_en=0; auipc_en=0;
    end
    endtask

    task check(input [31:0] expected, input [200:0] name);
    begin
        #1;
        if (alu_out !== expected)
            $display("FAILED: %s | expected = %h, got = %h", name, expected, alu_out);
        else
            $display(" PASSED: %s | result = %h", name, alu_out);
    end
    endtask

    // ---------------------------------
    // BEGIN TESTS
    // ---------------------------------
    initial begin

        // sample test values
        RS1      = 32'h00000010;
        RS2      = 32'h00000004;
        IM_32_I  = 32'hFFFFFFF0;   // -16
        IM_32_S  = 32'h00000008;
        IM_32_U  = 32'h00012000;
        PC       = 32'h00000080;
        shift_amount   = 5'd2;

        reset_controls;

        // ----------------------------
        // R-type Logic & Arithmetic
        // ----------------------------
        add_en = 1;  #5; check(RS1+RS2, "ADD"); reset_controls;
        sub_en = 1;  #5; check(RS1-RS2, "SUB"); reset_controls;
        and_en = 1;  #5; check(RS1&RS2, "AND"); reset_controls;
        or_en  = 1;  #5; check(RS1|RS2, "OR");  reset_controls;
        xor_en = 1;  #5; check(RS1^RS2, "XOR"); reset_controls;

        slt_en  = 1; #5; check(($signed(RS1)<$signed(RS2)), "SLT"); reset_controls;
        //sltu_en = 1; #5; check((RS1<RS2), "SLTU"); reset_controls;

        sll_en  = 1; #5; check((RS1<<shift_amount), "SLL"); reset_controls;
        srl_en  = 1; #5; check((RS1>>shift_amount), "SRL"); reset_controls;
        sra_en  = 1; #5; check(($signed(RS1)>>>shift_amount), "SRA"); reset_controls;

        // ----------------------------
        // I-type operations
        // ----------------------------
        addi_en = 1; #5; check(RS1 + IM_32_I, "ADDI"); reset_controls;
        andi_en = 1; #5; check(RS1 & IM_32_I, "ANDI"); reset_controls;
        ori_en  = 1; #5; check(RS1 | IM_32_I, "ORI");  reset_controls;
        xori_en = 1; #5; check(RS1 ^ IM_32_I, "XORI"); reset_controls;

        slti_en  = 1; #5; check(($signed(RS1) < $signed(IM_32_I)), "SLTI");  reset_controls;
        sltiu_en = 1; #5; check((RS1 < IM_32_I), "SLTIU"); reset_controls;

        slli_en  = 1; #5; check((RS1 << shift_amount), "SLLI");  reset_controls;
        srli_en  = 1; #5; check((RS1 >> shift_amount), "SRLI");  reset_controls;
        srai_en  = 1; #5; check(($signed(RS1) >>> shift_amount), "SRAI"); reset_controls;

        // ----------------------------
        // M-extension multiply
        // ----------------------------
        mul_en   = 1; #5; check(RS1*RS2, "MUL"); reset_controls;

        mulh_en  = 1; #5; check((($signed(RS1)*$signed(RS2))>>32), "MULH"); reset_controls;
        mulhsu_en= 1; #5; check((($signed(RS1)*RS2)>>32), "MULHSU"); reset_controls;
        mulhu_en = 1; #5; check(((RS1*RS2)>>32), "MULHU"); reset_controls;

        // ----------------------------
        // M-extension divide/remainder
        // ----------------------------
        div_en   = 1; #5; check($signed(RS1)/$signed(RS2), "DIV"); reset_controls;
        divu_en  = 1; #5; check(RS1/RS2, "DIVU"); reset_controls;

        rem_en   = 1; #5; check($signed(RS1)%$signed(RS2), "REM"); reset_controls;
        remu_en  = 1; #5; check(RS1%RS2, "REMU"); reset_controls;

        // ----------------------------
        // Store address calculations
        // ----------------------------
        sw_en = 1; #5; check(RS1 + IM_32_S, "SW address calc"); reset_controls;
        sh_en = 1; #5; check(RS1 + IM_32_S, "SH address calc"); reset_controls;
        sb_en = 1; #5; check(RS1 + IM_32_S, "SB address calc"); reset_controls;

        // ----------------------------
        // LUI & AUIPC
        // ----------------------------
        lui_en = 1;    #5; check(IM_32_U<<12, "LUI");   reset_controls;
        auipc_en = 1;  #5; check(PC + (IM_32_U<<12), "AUIPC"); reset_controls;

        $display("\n========================================");
        $display(" ALL RISC-V ALU TESTS COMPLETED");
        $display("========================================\n");

        
    end
initial 
begin
$shm_open("wave.shm");
$shm_probe("ACTMF");
#200;
$finish;
end

endmodule
