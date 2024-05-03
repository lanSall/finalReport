module FSM (clk, reset, start, randomize, rst, strt, rnd);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;

    output logic rst;
    output logic strt;
    output logic rnd;

    typedef enum 	logic [3:0] {IDLE, LFSR, PLAY,RESET} statetype;
    statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= RESET;
     else       state <= nextstate;

     always_comb
      case (state)
      IDLE:begin
        rst = 1'b0;
        strt = 1'b0;
        rnd = 1'b0;

        if(reset)                               nextstate <= RESET;
        else if(~randomize&&start&&~reset)      nextstate <= PLAY;
        else if(randomize&&~start&&~reset)      nextstate <= LFSR;
        else                                    nextstate <= IDLE;
      end

      RESET: begin 
        rst = 1'b1;
        strt = 1'b0;
        rnd = 1'b0;

        
        if(~randomize&&start&&~reset)           nextstate <= PLAY;
        else if(randomize&&~start&&~reset)      nextstate <= LFSR;
        else if(~randomize&&~start&&~reset)     nextstate <= IDLE;
        else                                    nextstate <= RESET;
      end
      
      LFSR: begin
        rst = 1'b0;
        strt = 1'b0;
        rnd = 1'b1;


        if(reset)                               nextstate <= RESET;
        else if(~randomize&&start&&~reset)      nextstate <= PLAY;
        else if(~randomize&&~start&&~reset)     nextstate <= IDLE;
        else                                    nextstate <= LFSR;
      end

      PLAY: begin
        rst = 1'b0;
        strt = 1'b1;
        rnd = 1'b0;

        if(reset)                               nextstate <= RESET;
        else if(randomize&&~reset&&~start)      nextstate <= LFSR;
        else if(~randomize&&~start&&~reset)     nextstate <= IDLE;
        else                                    nextstate <= PLAY;
      end
      endcase
endmodule

