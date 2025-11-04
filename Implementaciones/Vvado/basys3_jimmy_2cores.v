`timescale 1ns / 1ps



module basys3_jimmy_2cores(
    input clk,
    input btnC,
    input btnU,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );
    
    
    
    
    wire [7:0] cant_pares_general;
    wire [3:0] hundreds;
    wire [3:0] tens;
    wire [3:0] ones;
    wire [7:0] sum;
    
    wire reset;
    wire display_clk;
    
    wire [3:0] S_strobe_0;
    wire [7:0] prog_data_bus_0;
    wire [7:0] prog_addr_bus_0;
    reg [7:0] start_addr_bus_0;
    wire [7:0] mem_addr_bus_0;
    wire [7:0] mem_data_bus_0;
    wire [7:0] complete_bus_0;
    wire [7:0] resultado_0;
    reg  [7:0] cant_pares_0;
    
    
    
    wire [3:0] S_strobe_1;
    wire [7:0] prog_data_bus_1;
    wire [7:0] prog_addr_bus_1;
    reg [7:0] start_addr_bus_1;
    wire [7:0] mem_addr_bus_1;
    wire [7:0] mem_data_bus_1;
    wire [7:0] complete_bus_1;
    wire [7:0] resultado_1;
    reg  [7:0] cant_pares_1;
    
    
    
    jimmy james0(
        .jimmy_clk(clk),
        .reset(reset),
        .in_port_0(mem_data_bus_0),
        .in_port_1(start_addr_bus_0),
        .out_port_1(mem_addr_bus_0),
        .out_port_2(complete_bus_0),
        .out_port_3(resultado_0),
        .out_strobe(S_strobe_0),
        .inst_data_bus(prog_data_bus_0),
        .inst_address_bus(prog_addr_bus_0)
    );
    
    program_memory pm0(
        .address_bus(prog_addr_bus_0),
        .data_bus(prog_data_bus_0),
        .reset(reset),
        .program_clk(clk)
    );
    
    jimmy james1(
        .jimmy_clk(clk),
        .reset(reset),
        .in_port_0(mem_data_bus_1),
        .in_port_1(start_addr_bus_1),
        .out_port_1(mem_addr_bus_1),
        .out_port_2(complete_bus_1),
        .out_port_3(resultado_1),
        .out_strobe(S_strobe_1),
        .inst_data_bus(prog_data_bus_1),
        .inst_address_bus(prog_addr_bus_1)
    );
    
    program_memory pm1(
        .address_bus(prog_addr_bus_1),
        .data_bus(prog_data_bus_1),
        .reset(reset),
        .program_clk(clk)
    );
     
     EightPortArray rom_mem(
        .reset(reset),
        .DataBus0(mem_data_bus_0),
        .AddressBus0(mem_addr_bus_0),
        .DataBus1(mem_data_bus_1),
        .AddressBus1(mem_addr_bus_1)
     );
    
    always @ (negedge(S_strobe_0[3])) begin
      cant_pares_0 <= resultado_0;
    end
    
    always @ (negedge(S_strobe_1[3])) begin
      cant_pares_1 <= resultado_1;
    end
    
    always @(posedge(clk)) begin
        if (reset == 1) begin
            start_addr_bus_0 <= 8'd0;
            start_addr_bus_1 <= 8'd127;
        end
    end
    
    wire a, b,c,d;
    reg [31:0] cnt_ciclos;
    wire [31:0] data_to_show;
    
    sumador sumador_general(
        .in_0(cant_pares_0),
        .in_1(cant_pares_1),
        .in_2(8'b00000000),
        .in_3(8'b00000000),
        .out(cant_pares_general)
    );
    
    
    mux filtro(
        .in_port_0(cant_pares_general),
        .in_port_1(cnt_ciclos[23:8]),
        .selector(btnU),
        .out(data_to_show)
    );
    
    assign led = data_to_show[31:16];

    assign dp = 1'b1;
    assign a = complete_bus_0[0];
    assign b = complete_bus_1[0];
    
    and(c, a, b);
    and(d, clk, ~c);
    
    always @(negedge(d)) begin
        cnt_ciclos <= cnt_ciclos + 1;
    end
    
    reg  reset_sync_r1;
    reg  reset_sync_r2;
    
    always @(posedge clk) begin
        reset_sync_r1 <= ~btnC; // Captura la señal del botón (invertida, activa en alto)
        reset_sync_r2 <= reset_sync_r1; // Pasa por el segundo flip-flop
    end
    assign reset = reset_sync_r2;
    
    
    bin2bcd decoder(
        .bin(data_to_show[7:0]),
        .bcd({hundreds,tens,ones})
    );
    
    FreqDivider fd(
        .in_clk(clk),
        .reset(reset),
        .ratio(32'd100000),
        .out_clk(display_clk)
    );
    
    basys3_display_controller mydisplay(
        .disp_clk(display_clk),
        .reset(reset),
        .dig3(4'd0),
        .dig2(hundreds),
        .dig1(tens),
        .dig0(ones),
        .segments(seg),
        .anodes(an)
    );
    
    
    
endmodule