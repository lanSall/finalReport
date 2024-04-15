module FSM (clk, reset, start, randomize, rst, strt, rnd);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;

    output logic rst;
    output logic strt;
    output logic rnd;
    

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
        rst = 1'b1;
        strt = 1'b0;
        rnd = 1'b0;

        if(reset)                               nextstate <= IDLE;
        else if(~randomize&&start&&~reset)      nextstate <= play;
        else if(randomize&&~start&&~reset)      nextstate <= LFSR;
        else                                    nextstate <= IDLE;
      end
      LFSR: begin
        rst = 1'b0;
        strt = 1'b0;
        rnd = 1'b1;


        if(reset)                               nextstate <= IDLE;
        else if(randomize&&~reset)              nextstate <= LFSR;
        else if(~randomize&&start&&~reset)      nextstate <= play;
        else                                    nextstate <= LFSR;
      end
      play: begin
        rst = 1'b0;
        strt = 1'b1;
        rnd = 1'b0;

        if(reset)                               nextstate <= IDLE;
        else if(randomize&&~reset&&~start)      nextstate <= LFSR;
        else                                    nextstate <= play;
      end
      endcase
endmodule

