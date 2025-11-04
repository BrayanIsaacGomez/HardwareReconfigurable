`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 12:57:01
// Design Name: 
// Module Name: mux
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


module mux(
  input [7:0] in_port_0,
  input [15:0] in_port_1,

  input selector,
  output reg [31:0] out
  
);

  always @( selector ) begin
    case ( selector )
      1'd0: out <= {24'd0,     in_port_0};
      1'd1: out <= {in_port_1, 16'd0};
    endcase
  end
  
  
endmodule