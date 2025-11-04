`timescale 1ns / 1ps



module bin2bcd(
        input [7:0] bin,
        output [11:0] bcd
    );    
    assign bcd[11:8] = bin / 8'd100;
    assign bcd[7:4]  = (bin % 8'd100) / 8'd10;
    assign bcd[3:0]  = (bin % 8'd100) % 8'd10;     
endmodule