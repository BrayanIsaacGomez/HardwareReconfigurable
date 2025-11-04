`timescale 1ns / 1ps

// Opcodes
`define ADD_REG  6'b000000
`define SUB      6'b000001
`define MUL      6'b000010
`define MOV      6'b000100
`define NOP      6'b000111
`define LD_IMM   6'b100000
`define CMP      6'b100011
`define DEC      6'b100101
`define INPUT    6'b100110
`define OUTPUT   6'b100111
`define BRA      6'b101010
`define BHI      6'b101100
`define BEQ      6'b101101

`define LD_MEM	   6'b100001
`define LD_MEM_REG 6'b110000

// Control Logic States, One-Hot Encoded
`define FETCH      3'b001
`define EXECUTE    3'b010
`define WRITE_BACK 3'b100

module jimmy(
    input jimmy_clk,
    input reset,
    input  [7:0]  in_port_0,
    input  [7:0]  in_port_1,
    input  [7:0]  in_port_2,
    input  [7:0]  in_port_3,
  
    output [7:0] out_port_0,
    output [7:0] out_port_1,
    output [7:0] out_port_2,
    output [7:0] out_port_3,
    output reg [3:0] in_strobe,
    output reg [3:0] out_strobe,
  
    input  [7:0] inst_data_bus,
    output [7:0] inst_address_bus
    );
    
    // Registers
    reg [7:0] r[3:0]; // Register Bank
    reg [7:0] pc;     // Program Counter to Program Memory
    reg [7:0] sp;     // Stack Pointer to Data Memory
    reg Z;  // Zero Flag
    reg C;  // Carry Bit
    reg N;  // Negative Flag
    reg V;  // Overflow Flag
    
    // Data Memory
    reg [7:0] mem [255:0];  // The memory implemented as an array
  
    initial begin
      mem[ 0] = 8'h03; // 3
      mem[ 1] = 8'h05; // 5
      mem[ 2] = 8'h07; // 7
      mem[ 3] = 8'h0B; // 11
      mem[ 4] = 8'h0D; // 13
      mem[ 5] = 8'h11; // 17
      mem[ 6] = 8'h13; // 19
      mem[ 7] = 8'h17; // 23
      mem[ 8] = 8'h1D; // 29
      mem[ 9] = 8'h1F; // 31
      mem[10] = 8'h25; // 37
      mem[11] = 8'h29; // 41
      mem[12] = 8'h2B; // 43
      mem[13] = 8'h2F; // 47
      mem[14] = 8'h35; // 53
      mem[15] = 8'h3B; // 59
      mem[16] = 8'h3D; // 61
      mem[17] = 8'h43; // 67
      mem[18] = 8'h47; // 71
      mem[19] = 8'h49; // 73
      mem[20] = 8'h4F; // 79
      mem[21] = 8'h53; // 83
      mem[22] = 8'h59; // 89
      mem[23] = 8'h61; // 97
      mem[24] = 8'h65; // 101
      mem[25] = 8'h67; // 103
      mem[26] = 8'h6B; // 107
      mem[27] = 8'h6D; // 109
      mem[28] = 8'h71; // 113
      mem[29] = 8'h7F; // 127
      mem[30] = 8'h83; // 131
      mem[31] = 8'h89; // 137
      mem[32] = 8'h8B; // 139
      mem[33] = 8'h95; // 149
      mem[34] = 8'h97; // 151
      mem[35] = 8'h9D; // 157
      mem[36] = 8'hA3; // 163
      mem[37] = 8'hA7; // 167
      mem[38] = 8'hAD; // 173
      mem[39] = 8'hB3; // 179
      mem[40] = 8'hB5; // 181
      mem[41] = 8'hBF; // 191
      mem[42] = 8'hC1; // 193
      mem[43] = 8'hC5; // 197
      mem[44] = 8'hC7; // 199
      mem[45] = 8'hD3; // 211
      mem[46] = 8'hDF; // 223
      mem[47] = 8'hE3; // 227
      mem[48] = 8'hE5; // 229
      mem[49] = 8'hE9; // 233
      mem[50] = 8'hEF; // 239
      mem[51] = 8'hF1; // 241
      mem[52] = 8'hFB; // 251
    end
    
    // State Machine
    reg [2:0] state;
    
    // Special Registers
    reg [5:0] instruction;
    reg [1:0] ra;
    reg [1:0] rb;
    reg A7;
    reg B7;
    reg [7:0] result;
    
    wire [7:0]  in_port [3:0];
    reg  [7:0] out_port [3:0];
    
    // Signals and Wiring
    wire [5:0] cat1_opcode;
    wire [5:0] cat2_opcode;
    wire [1:0] cat1_ra;
    wire [1:0] cat1_rb;
    wire [1:0] cat2_ra;
    wire [7:0] argument;
    wire R7;
    
    wire [7:0] r0;     // These four signals
    wire [7:0] r1;     // make the cpu registers
    wire [7:0] r2;     // available as signals to
    wire [7:0] r3;     // the waveform simulator.
    assign r0 = r[0];  // This issue came up
    assign r1 = r[1];  // in EDAPlayground when 
    assign r2 = r[2];  // EPWave wouldn't show
    assign r3 = r[3];  // the registers as signals.
    
    assign inst_address_bus = pc;
    assign cat1_opcode = {2'b00,inst_data_bus[7:4]};
    assign cat2_opcode = inst_data_bus[7:2];
    assign cat1_ra = inst_data_bus[3:2];
    assign cat1_rb = inst_data_bus[1:0];
    assign cat2_ra = inst_data_bus[1:0];
    assign argument = inst_data_bus;
    assign R7 = result[7];
    assign  in_port[0] = in_port_0;
    assign  in_port[1] = in_port_1;
    assign  in_port[2] = in_port_2;
    assign  in_port[3] = in_port_3;
    assign out_port_0 = out_port[0];
    assign out_port_1 = out_port[1];
    assign out_port_2 = out_port[2];
    assign out_port_3 = out_port[3];
    
    wire [15:0] mult;
    assign mult  = r[rb] *r[ra];
  
    // Procedural Code
    
    always @(posedge(jimmy_clk)) begin
        if (reset == 0) begin
            state <= `FETCH;
            pc    <= 8'b0000_0000;
            sp    <= 8'b1111_1111;
            in_strobe  <= 4'b1111; 
            out_strobe <= 4'b1111;
        end
        else begin
            case(state)
                `FETCH: begin
                    in_strobe  <= 4'b1111;
                    out_strobe <= 4'b1111;
                    if (inst_data_bus[7]==1'b0) begin // Instruction Category 
                        instruction <= cat1_opcode;   // Category 1
                        ra <= cat1_ra;
                        rb <= cat1_rb;
                    end
                    else begin                        // Category 2
                        instruction <= cat2_opcode;
                        ra <= cat2_ra;
                        case(cat2_opcode)
                            `LD_IMM,
                          	`LD_MEM,
                            `LD_MEM_REG,
                            `CMP,
                          	`SUB,
                            `BRA, 
                            `BHI,
                            `BEQ:  pc <= pc + 8'd1;
                        endcase
                    end
                    state <= `EXECUTE;
                end
                `EXECUTE: begin
                    case(instruction)
                        `ADD_REG: begin
                            result <= r[ra] + r[rb];
                            A7 <= r[ra][7];
                            B7 <= r[rb][7];
                            state <= `WRITE_BACK;
                        end
                      `SUB: begin
                        result <= r[ra] - r[rb];
                            A7 <= r[ra][7];
                            B7 <= r[rb][7];
                            state <= `WRITE_BACK;
                        end
                        `MUL: begin
                            {r[rb],r[ra]} <= (ra==rb)?{mult[7:0],mult[7:0]}:(mult);
                            pc <= pc + 8'd1;
                            state <= `FETCH;
                        end      
                        `MOV: begin
                            r[ra] <= r[rb];
                            Z <= (r[rb]==8'd0)?1'b1:1'b0;
                            N <= r[rb][7];
                            V <= 0;
                            pc <= pc + 8'd1;
                            state <= `FETCH;
                        end
                        `NOP: begin
                            pc <= pc + 8'd1;
                            state <= `FETCH;
                        end
                        `LD_IMM: begin
                            r[ra] <= argument;
                            Z <= (argument==8'd0)?1'b1:1'b0;
                            N <= argument[7];
                            V <= 0;
                            pc <= pc + 8'd1;
                            state <= `FETCH;
                        end
                      	`LD_MEM: begin
                          r[ra] <= mem[argument];
                            Z <= (argument==8'd0)?1'b1:1'b0;
                            N <= argument[7];
                            V <= 0;
                            pc <= pc + 8'd1;
                            state <= `FETCH;
                          
                        end
                      `LD_MEM_REG: begin
                        r[ra] <= mem[r[argument]];
                            Z <= (argument==8'd0)?1'b1:1'b0;
                            N <= argument[7];
                            V <= 0;
                            pc <= pc + 8'd1;
                            state <= `FETCH;
                          
                        end
                        `CMP: begin
                            result <= r[ra] - argument;
                            A7 <= r[ra][7];
                            B7 <= argument[7];
                            state <= `WRITE_BACK;
                        end
                        `DEC: begin
                            result <= r[ra] - 8'd1;
                            A7 <= r[ra][7];
                            state <= `WRITE_BACK;
                        end   
                        `INPUT: begin
                            r[ra] = in_port[ra];
                            state <= `WRITE_BACK;
                        end
                        `OUTPUT: begin
                            out_port[ra] = r[ra];
                            state <= `WRITE_BACK;
                        end                        
                        `BRA: begin
                            pc <= argument;
                            state <= `FETCH;
                        end                         
                        `BHI: begin          //   11111111 > 00000000
                            if(C==0 && Z==0) 
                                pc <= argument;
                            else
                                pc <= pc + 8'd1;
                            state <= `FETCH;
                        end
                        `BEQ: begin
                            if(Z==1) 
                                pc <= argument;
                            else
                                pc <= pc + 8'd1;
                            state <= `FETCH;
                         end 
                    endcase
                end
                `WRITE_BACK: begin
                    case(instruction)
                        `ADD_REG: begin
                            r[ra] <= result;
                            V <= (A7&B7&~R7)|(~A7&~B7&R7);
                            N <= R7;
                            Z <= (result==8'd0)?1'b1:1'b0;
                            C <= (A7&B7)|(B7&~R7)|(~R7&A7);
                        end
                      `SUB: begin
                            r[ra] <= result;
                            V <= (A7&B7&~R7)|(~A7&~B7&R7);
                            N <= R7;
                            Z <= (result==8'd0)?1'b1:1'b0;
                            C <= (A7&B7)|(B7&~R7)|(~R7&A7);
                        end
                        `CMP: begin
                            V <= (A7&~B7&~R7)|(~A7&B7&R7);
                            N <= R7;
                            Z <= (result==8'd0)?1'b1:1'b0;
                            C <= (~A7&B7)|(B7&R7)|(R7&~A7);
                        end
                        `DEC: begin
                            r[ra] <= result;
                            V <= ~R7&A7;
                            N <= R7;
                            Z <= (result==8'd0)?1'b1:1'b0;
                        end   
                        `INPUT: 
                            in_strobe[ra] = 1'b0;
                        `OUTPUT:
                            out_strobe[ra] = 1'b0;
                    endcase
                    pc <= pc + 8'd1;
                    state <= `FETCH;
                end
                default: begin
                    state <= `FETCH;
                    pc    <= 8'b0000_0000;
                    sp    <= 8'b1111_1111;
                    in_strobe  <= 4'b1111; 
                    out_strobe <= 4'b1111;
                end
            endcase
        end        
	end
endmodule
