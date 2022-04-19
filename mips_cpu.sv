module mips_cpu(
    //时钟与清零
    input logic clk,reset,
    //存放指令的地址
    output logic [31:0] pc,
    //要执行的指令
    input logic [31:0] instrction,
    //由主译码器给出,判断是否写入存储
    output logic mem_write,
    output logic [31:0] alu_out,write_data,
    input logic [31:0] read_data
    );

    //中间连线
    logic mem_to_reg,alu_src,reg_dst,reg_write,jump,pc_src,zero,imm_src,eq_branch;
    logic [2:0] alu_control;
    //控制器
    controller controller(
        .operation_code(instrction[31:26]),
        .funct(instrction[5:0]),
        .zero(zero),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .pc_src(pc_src),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .jump(jump),
        .alu_control(alu_control),
        .imm_src(imm_src)
    );
    //数据路径
    data_path dp(
        .clk(clk),
        .reset(reset),
        .pc_src(pc_src),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .jump(jump),
        .alu_control(alu_control),
        .zero(zero),
        .pc(pc),
        .instrction(instrction),
        .alu_out(alu_out),
        .write_data(write_data),
        .read_data(read_data),
        .imm_src(imm_src)
    );
endmodule