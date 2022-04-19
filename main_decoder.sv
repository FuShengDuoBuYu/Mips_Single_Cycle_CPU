module main_decoder(
    //mips指令的前六位操作码
    input [5:0] operation_code,
    //是否从memory写入reg
    output logic mem_to_reg,
    //是否写数据存储器 DataMemory
    output logic mem_write,
    //若为beq指令,有可能发生跳转,从而pc值可能发生改变,置位1
    output logic branch,
    //为0代表alu的第二个处理数据是来自RegFile,为1来自指令
    output logic alu_src,
    //判断是指令中的[20:16](0)还是[15:11](1)写入RegFile
    output logic reg_dst,
    //判断是(1)否(0)需要写入reg_write
    output logic reg_write,
    //判断是(1)否(0)为jump指令
    output logic jump,
    //给alu_decoder的option
    output logic [1:0] alu_option,
    //输出I指令到底是需要无符号扩展(0)还是有符号扩展(1)
    output logic imm_src,
    //判断此时是beq指令(1),还是不是beq指令(0)
    output logic eq_branch
);
    //给出指令译码后的各个值
    logic [10:0] decoded_instruction_to_controls;

    assign {reg_write,reg_dst,alu_src,branch,mem_write,mem_to_reg,jump,alu_option,imm_src,eq_branch} = decoded_instruction_to_controls;

    //根据指令赋值
    always_comb
        case (operation_code)
            6'b000000: decoded_instruction_to_controls<=11'b11000001010;//R类型
            6'b100011: decoded_instruction_to_controls<=11'b10100100010;//lw
            6'b101011: decoded_instruction_to_controls<=11'b00101000010;//sw
            6'b000100: decoded_instruction_to_controls<=11'b00010000111;//beq
            6'b000101: decoded_instruction_to_controls<=11'b00010000110;//bne
            6'b001000: decoded_instruction_to_controls<=11'b10100000010;//addi
            6'b000010: decoded_instruction_to_controls<=11'b00000010010;//j
            6'b001101: decoded_instruction_to_controls<=11'b10100001100;//ori
            default: decoded_instruction_to_controls<=11'bxxxxxxxxxxx;//j
        endcase
endmodule