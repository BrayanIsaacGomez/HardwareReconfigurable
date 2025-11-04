`timescale 1ns / 1ps



module basys3_jimmy_4cores(
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
    
    wire [3:0] S_strobe_2;
    wire [7:0] prog_data_bus_2;
    wire [7:0] prog_addr_bus_2;
    reg [7:0] start_addr_bus_2;
    wire [7:0] mem_addr_bus_2;
    wire [7:0] mem_data_bus_2;
    wire [7:0] complete_bus_2;
    wire [7:0] resultado_2;
    reg  [7:0] cant_pares_2;
    
    wire [3:0] S_strobe_3;
    wire [7:0] prog_data_bus_3;
    wire [7:0] prog_addr_bus_3;
    reg [7:0] start_addr_bus_3;
    wire [7:0] mem_addr_bus_3;
    wire [7:0] mem_data_bus_3;
    wire [7:0] complete_bus_3;
    wire [7:0] resultado_3;
    reg  [7:0] cant_pares_3;
    
    
    
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
    
    jimmy james2(
        .jimmy_clk(clk),
        .reset(reset),
        .in_port_0(mem_data_bus_2),
        .in_port_1(start_addr_bus_2),
        .out_port_1(mem_addr_bus_2),
        .out_port_2(complete_bus_2),
        .out_port_3(resultado_2),
        .out_strobe(S_strobe_2),
        .inst_data_bus(prog_data_bus_2),
        .inst_address_bus(prog_addr_bus_2)
    );
    
    program_memory pm2(
        .address_bus(prog_addr_bus_2),
        .data_bus(prog_data_bus_2),
        .reset(reset),
        .program_clk(clk)
    );
    
    jimmy james3(
        .jimmy_clk(clk),
        .reset(reset),
        .in_port_0(mem_data_bus_3),
        .in_port_1(start_addr_bus_3),
        .out_port_1(mem_addr_bus_3),
        .out_port_2(complete_bus_3),
        .out_port_3(resultado_3),
        .out_strobe(S_strobe_3),
        .inst_data_bus(prog_data_bus_3),
        .inst_address_bus(prog_addr_bus_3)
    );
    
    program_memory pm3(
        .address_bus(prog_addr_bus_3),
        .data_bus(prog_data_bus_3),
        .reset(reset),
        .program_clk(clk)
    );
     
     EightPortArray rom_mem(
        .reset(reset),
        .DataBus0(mem_data_bus_0),
        .AddressBus0(mem_addr_bus_0),
        .DataBus1(mem_data_bus_1),
        .AddressBus1(mem_addr_bus_1),
        .DataBus2(mem_data_bus_2),
        .AddressBus2(mem_addr_bus_2),
        .DataBus3(mem_data_bus_3),
        .AddressBus3(mem_addr_bus_3)
     );
    
    always @ (negedge(S_strobe_0[3])) begin
      cant_pares_0 <= resultado_0;
    end
    
    always @ (negedge(S_strobe_1[3])) begin
      cant_pares_1 <= resultado_1;
    end
    
    always @ (negedge(S_strobe_2[3])) begin
      cant_pares_2 <= resultado_2;
    end
    
    always @ (negedge(S_strobe_3[3])) begin
      cant_pares_3 <= resultado_3;
    end
    
    always @(posedge(clk)) begin
        if (reset == 1) begin
            start_addr_bus_0 <= 8'd0;
            start_addr_bus_1 <= 8'd64;
            start_addr_bus_2 <= 8'd128;
            start_addr_bus_3 <= 8'd192;
        end
    end
    
    
    reg [31:0] cnt_ciclos;
    wire [31:0] data_to_show;
    
    sumador sumador_general(
        .in_0(cant_pares_0),
        .in_1(cant_pares_1),
        .in_2(cant_pares_2),
        .in_3(cant_pares_3),
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
    assign c = complete_bus_2[0];
    assign d = complete_bus_3[0];
    
    wire all_complete;
    assign all_complete = complete_bus_0[0] & complete_bus_1[0] & 
                          complete_bus_2[0] & complete_bus_3[0];
    

    always @(posedge clk or negedge reset) begin
        if (reset==0) begin
            cnt_ciclos <= 32'd0; // <-- ¡Añade el reset aquí!
        end
        else if (!all_complete) begin // Esta es la habilitación (enable)
            cnt_ciclos <= cnt_ciclos + 1;
        end
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