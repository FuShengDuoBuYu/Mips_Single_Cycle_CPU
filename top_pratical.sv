module top_pratical(
    input logic CLK100MHZ,
    input logic [15:0] SW,
    output logic [6:0] A2G,
    output logic [7:0] AN,
    output logic DP 
);
    logic [31:0] pc,instr,dataadr,writedata,readdata;
    logic [7:0] num1,num2,num3,num4;
    BCD10_4to2 n1(SW[3:0],num1);
    BCD10_4to2 n2(SW[7:4],num2);
    BCD10_4to2 n3(SW[11:8],num3);
    BCD10_4to2 n4(SW[15:12],num4);
    assign instr = {6'b000000,5'b00000,5'b00001,5'b00000};
    logic [31:0] res;
    mips_cpu mipscpu(CLK100MHZ, 0, 0, instr, 0, 0,res, {num1,num2,num3,num4});

    x7seg_adder x(CLK100MHZ,0,A2G,DP,AN,res);
endmodule