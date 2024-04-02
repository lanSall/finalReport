// testbench to prove maximal LFSR
module tb ();

   //logic variables to route input and output to DUT
    logic clk;
    logic reset;
    logic [15:0] seed;
    

   //create file handles to write results to a file
   
   // instantiate device under test (small LFSR)
    lfsr dut(seed, clk, reset, seed);
   //set up a clock signal
   always     
     begin
	clk = 1; #1; clk = 0; #1;
     end
   
   integer handle3;
    integer desc3;

      initial
     begin
	// Gives output file name
	handle3 = $fopen("lfsr.out");
	// Tells when to finish simulation
	#1000 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b /n%b /n%b /n%b", seed[3:0], seed[7:4], seed[11:8], seed[15:12]
		     );
     end   
	//set up output file
	//set up any book keeping variables you may want to use
	//set up a starting seed.  What happens with all 0s?
	//reset your DUT
	//save the initial output of your DUT to compare with current output
	//and see whenb you repeat
     

   always @(posedge clk)
   // check results on falling edge of clk
   always @(negedge clk) begin
		if(~reset) begin
      
		//check if your output equals the initial output 
		//if so, report how many iterations it took to repeat
		//this should be (2^n) - 1
		//if the output never repeats for 2^n iterations, report that
		end
	end
   
endmodule // tb

