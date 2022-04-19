//控制单元
module controller (
    input logic [5:0] operation_code,funct,
    input logic zero,
    output logic mem_to_reg,mem_write,
    output logic pc_src,alu_src,
    output logic reg_dst,reg_write,
    output logic jump,
    output logic [2:0] alu_control,
    output logic imm_src
);
    //alu操作码
    logic [1:0] alu_option;
    //用于确定是否是pc_src的分支
    logic branch;
    //用于确定是否为beq或bne
    logic eq_branch;
    //主译码器
    main_decoder md(
        .operation_code(operation_code),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .branch(branch),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .jump(jump),
        .alu_option(alu_option),
        .imm_src(imm_src),
        .eq_branch(eq_branch)
    );

    //alu译码器
    alu_decoder ad(
        .funct(funct),
        .alu_option(alu_option),
        .alu_control(alu_control)
    );
    
    //pc_src
    assign pc_src = (zero&branch&eq_branch)|(~zero&branch&~eq_branch);
endmodule