/*module lfsr(clk, reset, seed, shift_seed);
//inputs and outputs for a smaller implementation
//perhaps 8 or 16 bits

input logic [15:0] seed;
input logic reset;
input logic clk;
output logic [15:0] shift_seed;

logic [14:0] temp;

always_ff @(posedge clk)
    if (reset)  shift_seed <= seed;
    else 
    begin
    temp = shift_seed[14:0];
    shift_seed[15:1] <= temp;
    shift_seed[0]    <= ~(shift_seed[15] ^ shift_seed[14] ^ shift_seed[12] ^ shift_seed[3]); 
    end


//your implementation of the LFSR.  Remember that this 
//implementation has memory so it should be done 
//with some form of a flip-flop based register

endmodule*/

module lfsr64 (clk, reset, seed, shift_seed);
input logic [63:0] seed;
input logic reset;
input logic clk;
output logic [63:0] shift_seed;

logic [14:0] temp;

always_ff @(posedge clk)
    if (reset)  shift_seed <= seed;
    else 
    begin
    temp = shift_seed[62:0];
    shift_seed[63:1] <= temp;
    shift_seed[0]    <= ~(shift_seed[63] ^ shift_seed[62] ^ shift_seed[60] ^ shift_seed[59]); 
    end
//inputs and outputs for the full seed size (64 bits)

//either build a 64 bit version using your smaller implementation above
//or use the same methods from the xilinx document to build a full
//64 bit version

endmodule