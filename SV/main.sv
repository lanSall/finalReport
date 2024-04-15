module main(clk, reset, start, randomize, grid_evolve);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;

    logic rst;
    logic strt;
    logic rnd;
    logic [63:0]grid;
    logic [63:0]seed;
    
    always@(*)
        case({reset,randomize,start})
        3'b100 : seed <=64'b0001111000000000000000000000000000000000000000000000000000000000;
        3'b010 : seed <=grid;
        endcase
        

    output logic [63:0] grid_evolve;

    //set is a mux for inputing our seeds

    FSM dut1(clk, reset, start, randomize, rst, strt, rnd);
    flopenr #(64) dut2(clk, rst, strt,seed,grid, grid_evolve);
    datapath dut3(grid_evolve, grid);
    lfsr64 dut4(clk, rst, grid_evolve, grid);
endmodule