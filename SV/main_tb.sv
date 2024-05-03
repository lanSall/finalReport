`timescale 1ns / 1ps
module stimulus ();
    logic  clk;
    logic  reset;
    logic  start;
    logic  randomize;
    logic  [63:0]muxseed;
    logic  [63:0] grid;

    main dut(clk, reset, start, randomize,muxseed, grid);

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

   always @ ( negedge clk)
     begin
	desc3 = handle3;
   $fdisplay(desc3, "reset = %b start = %b randomize = %b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n--------", 
		     reset, start, randomize, grid[7:0], grid[15:8], grid[23:16], grid[31:24],grid[39:32], grid[47:40], grid[55:48],grid[63:56],);
     end   

    initial 
     begin      
        
      muxseed<=64'b0011000000111010000100000010110010000000111010000011100000011000;
      #0 randomize <= 1'b0;
      #0 start <= 1'b0;
      #0 reset <= 1'b1;
      #10 reset <= 1'b0;
      #0 start <= 1'b1;
      #80 start <= 1'b0;
      #0 randomize <= 1'b1;
      #50 reset <= 1'b1;
       

     end
endmodule