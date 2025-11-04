`timescale 1ns / 1ps

// Opcodes
`define OP_ADD      4'b0000
`define OP_SUB      4'b0001
`define OP_MUL      4'b0010
`define OP_MOV      4'b0100
`define OP_NOP      4'b0111
`define OP_LD_IMM   6'b100000
`define OP_CMP      6'b100011
`define OP_DEC      6'b100101
`define OP_INPUT    6'b100110
`define OP_OUTPUT   6'b100111
`define OP_BRA      6'b101010
`define OP_BHI      6'b101100
`define OP_BEQ      6'b101101



module program_memory(
    input  [7:0] address_bus,
    output [7:0] data_bus,
    input  reset,
    input program_clk
    );
    
    reg [7:0] program_rom [255:0];
    assign data_bus = program_rom[address_bus];
    
    always @(posedge(program_clk))
        if (reset == 0) begin
          
program_rom	[	0	]	<=	{	`OP_LD_IMM,2'd0	}	;
program_rom	[	1	]	<=	{	8'd0	}	;
program_rom	[	2	]	<=	{	`OP_LD_IMM,2'd1	}	;
program_rom	[	3	]	<=	{	8'd0	}	;
program_rom	[	4	]	<=	{	`OP_LD_IMM,2'd2	}	;
program_rom	[	5	]	<=	{	8'd0	}	;
program_rom	[	6	]	<=	{	`OP_LD_IMM,2'd3	}	;
program_rom	[	7	]	<=	{	8'd0	}	;
program_rom	[	8	]	<=	{	`OP_CMP, 2'd2	}	;
program_rom	[	9	]	<=	{	8'd63	}	;/// CONSULTAS DE DIRECCIONES DE MEMORIA
program_rom	[	10	]	<=	{	`OP_BHI,2'd0	}	;
program_rom	[	11	]	<=	{	8'd37	}	;
program_rom	[	12	]	<=	{	`OP_INPUT,2'd1	}	;
program_rom	[	13	]	<=	{	`OP_ADD,2'd1,2'd2	}	;
program_rom	[	14	]	<=	{	`OP_OUTPUT,2'd1	}	;
program_rom	[	15	]	<=	{	`OP_INPUT,2'd0	}	;
program_rom	[	16	]	<=	{	`OP_CMP, 2'd0	}	;
program_rom	[	17	]	<=	{	8'b1	}	;
program_rom	[	18	]	<=	{	`OP_BHI,2'd0	}	;
program_rom	[	19	]	<=	{	8'd24	}	;
program_rom	[	20	]	<=	{	`OP_BEQ, 2'b0	}	;
program_rom	[	21	]	<=	{	8'd32	}	;
program_rom	[	22	]	<=	{	`OP_BRA, 2'd0	}	;
program_rom	[	23	]	<=	{	8'd29	}	;
program_rom	[	24	]	<=	{	`OP_LD_IMM,2'd1	}	;
program_rom	[	25	]	<=	{	8'd2	}	;
program_rom	[	26	]	<=	{	`OP_SUB,2'd0,2'd1	}	;
program_rom	[	27	]	<=	{	`OP_BRA, 2'd0	}	;
program_rom	[	28	]	<=	{	8'd16	}	;
program_rom	[	29	]	<=	{	`OP_LD_IMM,2'd1	}	;
program_rom	[	30	]	<=	{	8'd1	}	;
program_rom	[	31	]	<=	{	`OP_ADD, 2'd3, 2'd1	}	;
program_rom	[	32	]	<=	{	`OP_LD_IMM,2'd1	}	;
program_rom	[	33	]	<=	{	8'd1	}	;
program_rom	[	34	]	<=	{	`OP_ADD, 2'd2, 2'd1	}	;
program_rom	[	35	]	<=	{	`OP_BRA, 2'd0	}	;
program_rom	[	36	]	<=	{	8'd8	}	;
program_rom	[	37	]	<=	{	`OP_LD_IMM,2'd2	}	;
program_rom	[	38	]	<=	{	8'd1	}	;
program_rom	[	39	]	<=	{	`OP_OUTPUT,2'd2	}	;
program_rom	[	40	]	<=	{	`OP_OUTPUT,2'd3	}	;

     end
endmodule
