module data_path(
    //时钟与复位器?
    input logic clk,reset,
    //判断pc是直接加4(0)还是有beq跳转(1)
    input logic pc_src,
    input logic mem_to_reg,
    input logic alu_src,reg_dst,
    input logic reg_write,jump,
    input logic imm_src,
    input logic eq_branch,
    input logic [2:0] alu_control,
    //输出是否为0
    output logic zero,
    //指令地址
    output logic [31:0] pc,
    //指令
    input logic [31:0] instrction,
    //要放到数据存储器的数据
    output logic [31:0] alu_out,write_data,
    //读取出来的数据放到RegFile
    input logic [31:0] read_data
);
    logic [4:0] write_reg;
    logic [31:0] pc_next,pc_next_branch,pc_plus4,pc_branch;
    //ALU处理的两个数
    logic [31:0] src_a,src_b;
    //扩展后的数据
    logic [31:0] sign_imm,unsign_imm,sign_immsh;
    //结果
    logic [31:0] result;

    //next pc
    //带时钟的更新pc的触发器
    flopr #(32) pc_reg(.clk(clk),.reset(reset),.d(pc_next),.q(pc));
    //pc加4顺序执行后一条指令
    adder pc_add1(.a(pc),.b(32'b100),.res(pc_plus4));
    //左移两位
    shift_left2 sl2(.a(sign_imm),.y(sign_immsh));
    //beq的指令位置
    adder pc_add2(.a(sign_immsh),.b(pc_plus4),.res(pc_branch));
    //两个选择器
    mux_2 #(32) pc_mux1(.data0(pc_plus4),.data1(pc_branch),.select(pc_src),.result(pc_next_branch));
    mux_2 #(32) pc_mux2(.data0(pc_next_branch),.data1({pc_plus4[31:28],instrction[25:0],2'b00}),.select(jump),.result(pc_next));

    //register file
    reg_file rf(.clk(clk),
                .we3(reg_write),
                .ra1(instrction[25:21]),
                .ra2(instrction[20:16]),
                .wa3(write_reg),
                .wd3(result),
                .rd1(src_a),
                .rd2(write_data)           
    );
    mux_2 #(5) wr_mux(.data0(instrction[20:16]),
                      .data1(instrction[15:11]),
                      .select(reg_dst),
                      .result(write_reg)
    );
    mux_2 #(32) result_mux(.data0(alu_out),
                           .data1(read_data),
                           .select(mem_to_reg),
                           .result(result)
    );
    sign_extension se(.a(instrction[15:0]),.y(sign_imm));
    unsign_extension unse(.a(instrction[15:0]),.y(unsign_imm));
    
    //alu
    //是有符号数还是无符号数
    logic [31:0] imm_b;
    mux_2 #(32) src_immi_mux(.data0(unsign_imm),.data1(sign_imm),.select(imm_src),.result(imm_b));
    mux_2 #(32) src_b_mux(.data0(write_data),.data1(imm_b),.select(alu_src),.result(src_b));
    ALU_32bit alu(.ALUcont(alu_control),
                  .A(src_a),
                  .B(src_b),
                  .result(alu_out),
                  .zero(zero)
    );
endmodule