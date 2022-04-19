module alu_decoder(
    //mips指令的后6位
    input logic [5:0] funct,
    //主译码器给出的R型指令的具体类型
    input logic [1:0] alu_option,
    //输出的真正的alu操作值
    output logic [2:0] alu_control
);
    //获取alu_control的值
    always_comb
        case(alu_option)
            //加 for lw/sw/addi
            2'b00: alu_control <= 3'b010;
            //减 for beq
            2'b01: alu_control <= 3'b110;
            //或 for ori
            2'b11: alu_control <=3'b001;
            //R型取决于funct
            default: case (funct)
                6'b100000 : alu_control <= 3'b010; //加
                6'b100010 : alu_control <= 3'b110; //减
                6'b100100 : alu_control <= 3'b000; //与
                6'b100101 : alu_control <= 3'b001; //或
                6'b101010 : alu_control <= 3'b111; //SLT小于置位
                default: alu_control <= 3'bxxx; //未定义
            endcase
        endcase
endmodule