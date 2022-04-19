//程序计数pc
//可复位d触发器
module flopr #(parameter WIDTH=8)(
    input logic clk,reset,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);
    //d触发器
    always_ff @(posedge clk or posedge reset) begin
        if(reset) q<=0;
        else q<=d;
    end
endmodule