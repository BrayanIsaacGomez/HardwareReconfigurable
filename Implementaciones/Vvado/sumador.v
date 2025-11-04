`timescale 1ns / 1ps


module sumador(
  input [7:0] in_0,
  input [7:0] in_1,
  input [7:0] in_2,
  input [7:0] in_3,
  output reg [8:0] out
  
);

  always @( * ) begin
    out <= in_0 + in_1 + in_2 + in_3;
  end
  
  
endmodule