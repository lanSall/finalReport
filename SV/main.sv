module main(clk, reset, start, randomize, grid);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;

    logic rst;
    logic strt;
    logic rnd;
    logic [63:0]set = 64'b1101101110010101101101101110010110101101101101110010101101101101;
    logic [63:0]grid_evolve;

    output logic [63:0] grid;

    //set is a mux for inputing our seeds

    FSM dut1(clk, reset, start, randomize, rst, strt, rnd);
    flopenr #(64) dut2(clk, rst, strt,set,grid, grid_evolve);
    datapath dut3(grid_evolve, grid);
    lfsr64 dut4(clk, rst, grid, grid_evolve);
endmodule