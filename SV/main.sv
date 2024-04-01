module FSM (clk, reset, start, randomize, seed):
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;

    output logic [63:0] seed;

    assign seed = 64'h0412_6424_0034_3C28;

    typedef enum 	logic [3:0] {IDLE, LFSR, play} statetype;
    statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= IDLE;
     else       state <= nextstate;

     

endmodule