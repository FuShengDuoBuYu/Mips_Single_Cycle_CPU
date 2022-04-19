module x7seg_adder(
    input logic clk,
    input logic clr,
    output logic [6:0] a2g,
    output logic dp,
    output logic [7:0] an,
    input logic [31:0] res
);
    
    logic [19:0] clkdiv;
    logic [2:0] s;
    logic [4:0] digit;
    assign s = clkdiv[19:17];

    always_comb
    case(s)
        //��ʾ�߶�����ܵ���������
        0:digit = {1'b0,res[7:4]};
        1:digit = {1'b0,res[3:0]};
        2:digit = 5'b10001;
        3:digit = {1'b0,res[7:4]};
        4:digit = {1'b0,res[3:0]};
        5:digit = 5'b10000;
        6:digit = {1'b0,res[7:4]};
        7:digit = {1'b0,res[3:0]};
        
        
        default : digit = 5'b00000;
    endcase
    
    
    
    //�߶�����ܵķ�ʱ��ʾ
    always_comb
    case(s)
        0:an = 8'b0111_1111;
        1:an = 8'b1011_1111;
        2:an = 8'b1101_1111;
        3:an = 8'b1110_1111;
        4:an = 8'b1111_0111;
        5:an = 8'b1111_1011;
        6:an = 8'b1111_1101;
        7:an = 8'b1111_1110;
        default : an = 8'b1111_1111;
    endcase

    
    //ʱ�ӷ�Ƶ��
    always @(posedge clk or posedge clr) 
        begin
            if(clr==1) 
                clkdiv <=0; 
            else
                clkdiv <=clkdiv+1; 
        end 
    Hex7Seg h7(.x(digit), .a2g(a2g));
   
endmodule
