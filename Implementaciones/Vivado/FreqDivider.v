`timescale 1ns / 1ps



module FreqDivider(
    input in_clk,
    input reset,
    input [31:0] ratio,
    output reg out_clk
    );
    
    reg [31:0] count;
	 
	always @(posedge in_clk)
	 if (reset == 0) begin
	   count <= 32'd0;
	   out_clk <= 1'b0;
	 end
	 else  begin
        count <= count + 1;
		  if (count==(ratio/2))
		  begin
		     count <= 32'd0;
			 out_clk <= ~out_clk;
		  end
		end
    
    
endmodule
