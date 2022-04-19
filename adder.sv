//加法器
module adder(
    input logic [31:0] a,b,
    output logic [31:0] res
);
    assign res = a+b;
endmodule