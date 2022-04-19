`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/19 14:02:57
// Design Name: 
// Module Name: ALU_32bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_32bit(
    input logic [2:0] ALUcont,
    input logic [31:0] A,
    input logic [31:0] B,
    output logic [31:0] result,
    output logic zero
    );
    
    always@(*)
        begin
            case(ALUcont)
                //AND
                3'b000:
                    begin
                        result=A&B;
                        zero=(result==0)?1:0;
                    end
                //OR
                3'b001:
                    begin
                        result=A|B;
                        zero=(result==0)?1:0;
                    end
                //+
                3'b010:
                    begin
                        result=A+B;
                        zero=(result==0)?1:0;
                    end
                //not used
                //3'b011:
                //AND !B
                3'b100:
                    begin
                        result=A&(~B);
                        zero=(result==0)?1:0;
                    end
                //OR !B
                3'b101:
                    begin
                        result=A|(~B);
                        zero=(result==0)?1:0;
                    end
                //-
                3'b110:
                    begin
                        result=A-B;
                        zero=(A==B)?1:0;
                    end
                //SLT
                3'b111:
                    begin
                        result=(A<B)?1:0;
                        zero=(result==0)?1:0;
                    end
            endcase
        end
endmodule
