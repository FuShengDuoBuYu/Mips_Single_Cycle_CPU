//寄存器文件
module reg_file (
    input logic clk,
    //写使能
    input logic we3,
    //对应指令的rs,rt,rd,即第一个,第一个读寄存器的编号,写入寄存器的编号
    input logic [4:0] ra1,ra2,wa3,
    //写入的数据
    input logic [31:0] wd3,
    //r1,r2寄存器上的值
    output logic [31:0] rd1,rd2
);
    //0号寄存器值恒为0共32个32位寄存器
    logic [31:0] regFile[31:0];
    
    always_ff @(posedge clk)
        //如果有使能,那么就把数据写入到wa3这个位置中
        if(we3) regFile[wa3] <= wd3;
    
    //读取数据,如果不是零号寄存器,就直接输出,否则为0
    assign rd1 = (ra1!=0) ? regFile[ra1]:0;
    assign rd2 = (ra2!=0) ? regFile[ra2]:0;
endmodule