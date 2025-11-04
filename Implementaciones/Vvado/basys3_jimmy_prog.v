`timescale 1ns / 1ps



module basys3_jimmy_prog(
    input clk,
    input btnC,
    input btnU,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );
    
    
    wire [7:0] prog_data_bus;
    wire [7:0] prog_addr_bus;
    
    wire [3:0] S_strobe;
    wire [3:0] hundreds;
    wire [3:0] tens;
    wire [3:0] ones;
    wire [7:0] sum;
    reg  [7:0] cant_pares;
    wire reset;
    wire display_clk;
    
    reg [7:0] start_addr_bus;
    wire [7:0] mem_addr_bus;
    wire [7:0] mem_data_bus;
    wire [7:0] complete_bus;
    wire [7:0] resultado;
    wire a, b;
    reg [31:0] cnt_ciclos;
    wire [31:0] data_to_show;
    
    
    jimmy james(
        .jimmy_clk(clk),
        .reset(reset),
        .in_port_0(mem_data_bus),
        .in_port_1(start_addr_bus),
        
        .out_port_1(mem_addr_bus),
        .out_port_2(complete_bus),
        .out_port_3(resultado),
        .out_strobe(S_strobe),
        .inst_data_bus(prog_data_bus),
        .inst_address_bus(prog_addr_bus)
    );
    
    program_memory pm(
        .address_bus(prog_addr_bus),
        .data_bus(prog_data_bus),
        .reset(reset),
        .program_clk(clk)
    );
     
     EightPortArray rom_mem(
        .reset(reset),
        .DataBus0(mem_data_bus),
        .AddressBus0(mem_addr_bus)
     );
    
    always @ (negedge(S_strobe[3])) begin
      cant_pares <= resultado;
    end
    
    always @(posedge(clk)) begin
        if (reset == 0) begin
            start_addr_bus <= 8'd0;
        end
    end
    
    mux filtro(
        .in_port_0(cant_pares),
        .in_port_1(cnt_ciclos[23:8]),
        .selector(btnU),
        .out(data_to_show)
    );
    
    assign led = data_to_show[31:16];

    assign dp = 1'b1;
    assign a = complete_bus[0];
    
    and(b, ~a, clk);
    always @(negedge(b)) begin
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