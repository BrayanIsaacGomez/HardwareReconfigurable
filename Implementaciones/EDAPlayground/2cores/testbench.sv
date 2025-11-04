`timescale 1ns / 1ps

module testing_jimmy_prog1();
    reg clk;
    reg reset;
    wire [7:0] prog_data_bus;
    wire [7:0] prog_addr_bus;
    wire [3:0] S_strobe;
    wire [7:0] sum;
  
  reg [7:0] start_addr;
    reg [7:0] B;
    reg [7:0] S;
  
  wire [7:0] mem_addr_bus;
  wire [7:0] mem_data_bus;
  
  
  reg [31:0] contador;
  wire contador_enable;
  wire done;
  assign done = sum[0];
  reg selector;
  wire [7:0] out_mux;
  wire [7:0] resultado;
  
  
  
  
  EightPortArray rom(
    .reset(reset),
    .AddressBus0(mem_addr_bus),
    .DataBus0(mem_data_bus)
  );
  
  
    
    jimmy james(
        .jimmy_clk(clk),
        .reset(reset),
      .in_port_0(mem_data_bus),
      .in_port_1(start_addr),
      .out_port_0(mem_addr_bus),
      .out_port_2(sum),
      .out_port_3(resultado),
        .out_strobe(S_strobe),
        .inst_data_bus(prog_data_bus),
        .inst_address_bus(prog_addr_bus)
    );
    
    program_memory1 pm(
        .address_bus(prog_addr_bus),
        .data_bus(prog_data_bus),
        .reset(reset),
        .program_clk(clk)
    );
  
    always #5 clk = !clk;
  
  and g1( contador_enable, ~done, clk);
  
  always @(negedge( contador_enable)) begin
    contador <= contador + 1;
    
  end
  
  mux8_1 mux(
    .a(sum),
    .b(contador[7:0]),
    .sel(selector),
    .out(out_mux)
  );
  
  
  
  

  always @ (negedge(S_strobe[0])) begin
      S <= sum;
    end
    
    initial begin
        $dumpfile("test.vcd"); 
      $dumpvars(0,testing_jimmy_prog1); 
        clk <= 0;
        reset <= 1;
      start_addr <= 0;
      selector = 0;
      contador <= 0;
        B <= 0;
        S <= 0;
       #10;
    reset <= 0;
      selector = 1;
    #10;
    reset <= 1;
      selector = 0;
    #10;
      B <= 5;
        #50;
        

      #1000;
      #10; selector <= 0;
      #10; selector <= 1;
      #10; selector <= 0;
      #10000;
      #10000;
      #10000;
      
		
      #1000;
            #10; selector <= 0;
      #10; selector <= 1;
      #10; selector <= 0;
      #10;
        $finish;
    end
    
endmodule
