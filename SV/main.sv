module main(clk, reset, start, randomize, grid);
    input logic clk;
    input logic reset;
    input logic start;
    input logic randomize;

    logic rst;
    logic strt;
    logic rnd;
    logic [63:0]grid_evolve;
    logic [63:0]seed;
    logic [63:0]lfsrout;
    logic [63:0]flopout;

    output logic [63:0] grid;
    
    always@(*) 
        case({rst,rnd,strt})
        3'b100 : seed <=64'b0000000000000000000000000000000011100000000000000000000000000000;
        3'b010 : seed <=lfsrout;
        3'b001 : seed <=grid;
        endcase
        // to implement this as a with multiple values chagne the reset value to a holder variable and create a case statement used to assing values to it
    

    FSM dut1(clk, reset, start, randomize, rst, strt, rnd);

    flopenr #(64) dut2(clk, rst, strt, seed, grid, grid_evolve);
    datapath dut3(grid_evolve, grid);

    flopenr #(64) dut(clk, rst, strt, seed, lfsrout, flopout);
    lfsr64 dut4(clk, rst, flopout, lfsrout);
endmodule