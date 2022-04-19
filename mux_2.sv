//2:1复用器
module mux_2 #(parameter WIDTH=8)(
    input logic [WIDTH-1:0] data0,data1,
    input logic select,
    output logic [WIDTH-1:0] result
);
    assign result = select?data1:data0;
endmodule