`timescale 1ns / 1ps

module mux8_1(
  input [7:0] a,
  input [7:0] b,
  input sel,
  output reg [7:0] out
  
);
  
  always @( sel ) begin
    case ( sel )
      1'd0: out <= a;
      1'd1: out <= b;
    endcase
  end
  
  
endmodule