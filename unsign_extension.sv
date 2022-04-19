//无符号扩展
module unsign_extension(
    input logic [15:0] a,
    output logic [31:0] y
);
  assign y = {16'b0000000000000000,a};
endmodule