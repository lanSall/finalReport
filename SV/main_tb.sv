`timescale 1ns / 1ps
module stimulus ();
    logic  clk;

    logic  reset;
   
    logic  [63:0] seed = 64'h0412_6424_0034_3C28;
    logic         randomize;
    logic         play;
    logic  [63:0] grid;
    logic  [63:0] next_grid;

    //FSM dut0(clk, reset, start, randomize, seed);
    datapath dut1(seed, grid);
    //flop #(64) dut2(clk, grid, next_grid);

    integer handle3;
    integer desc3;
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("main.out");
	// Tells when to finish simulation
	#1000 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b || %b \n%b || %b \n%b || %b \n%b || %b \n%b || %b \n%b || %b \n%b || %b \n%b || %b \n--------------------" , 
		     seed[7:0], grid[7:0], seed[15:8], grid[15:8], seed[23:16], grid[23:16], seed[31:24], grid[31:24],seed[39:32], grid[39:32],seed[47:40], grid[47:40],seed[55:48], grid[55:48],seed[63:56], grid[63:56],);
     end   

    initial 
     begin      
        #0 seed = seed;
        #10 next_grid = grid;
        #0 seed = next_grid;
        #10 next_grid = grid;
        #0 seed = next_grid;
        #10 next_grid = grid;
        #0 seed = next_grid;
        #10 next_grid = grid;
       
     end
endmodule