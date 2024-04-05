module FSM (clk, reset, start, randomize, inputSeed, outputSeed);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;
    input logic [63:0] inputSeed;
    output logic [63:0] outputSeed;

    //assign seed = 64'h0412_6424_0034_3C28;

    typedef enum 	logic [3:0] {IDLE, LFSR, play} statetype;
    statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= IDLE;
     else       state <= nextstate;

     always_comb
      case (state)
      IDLE: begin 
        outputSeed = 64'h0412_6424_0034_3Ca8;

        if(reset)           nextstate <= IDLE;
        else if(randomize)  nextstate <= LFSR;
        else                nextstate <= IDLE;
      end
      LFSR: begin
        outputSeed = 64'h0412_6424_0034_3C28;

        if(reset)           nextstate <= IDLE;
        else if(randomize)  nextstate <= LFSR;
        else if(start)      nextstate <= play;
        else                nextstate <= LFSR;
      end
      play: begin
        outputSeed = 64'h0412_6424_0034_3C28;

        if(reset)           nextstate <= IDLE;
        else if(randomize)  nextstate <= LFSR;
        else                nextstate <= play;
      end
      endcase
endmodule
