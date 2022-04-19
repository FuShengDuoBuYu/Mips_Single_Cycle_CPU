module dmem(
    //时钟与使能
    input logic clk, we,
    input logic[31:0] a,wd,
    output logic[31:0] rd
);
    logic [31:0] RAM[63:0];
    assign rd = RAM[a[31:2]];// word aligned
    always_ff@(posedge clk)
    //如果有使能就写入
    if (we) RAM[a[31:2]]<= wd;
endmodule
