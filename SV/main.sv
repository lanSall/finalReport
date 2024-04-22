module main(clk, reset, start, randomize, muxseed, grid);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;
    input logic [63:0] muxseed;

    logic rst;
    logic strt;
    logic rnd;

    logic [63:0]grid_evolve;
    logic [63:0]lfsrout;
    logic [63:0]datapathout;

    output logic [63:0] grid;
    
    always@(*)
        case({rst,rnd,strt})
        3'b100 : grid <= muxseed;
        3'b010 : grid <= lfsrout;
        3'b001 : grid <= datapathout;
        default: grid <= 64'b0000000000111000000000000000000000000000000000000000000000000000;
        endcase
        
    //set is a mux for inputing our seeds

    FSM dut1(clk, reset, start, randomize, rst, strt, rnd);
    flopenr #(64) dut2(clk, grid, grid_evolve);
    datapath dut3(grid_evolve, datapathout);
    lfsr64 dut4(clk, rst, grid_evolve, lfsrout);
endmodule