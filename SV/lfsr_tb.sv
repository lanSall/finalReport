`timescale 1ns / 1ps
module stimulus ();

    // Logic variables to route input and output to DUT
    logic clk;
    logic reset;
    logic [15:0] seed;
    logic [15:0] seedInput;
    logic [15:0] nextSeedInput;

    // File handles for writing results
    integer handle3;
    integer desc3;

    // Instantiate the device under test (LFSR)
    lfsr dut1(clk, reset,nextSeedInput, seedInput);
    flop #(16) dut2(clk, seedInput, nextSeedInput);

    // Clock signal generation
    always begin
        clk = 1; #1; clk = 0; #1;
    end

    // Initial block
    initial begin
        // Open output file
        handle3 = $fopen("lfsr.out");

        // Initialize seed and reset
        #0 seed = 16'h0;
        #0 reset =1'b1;
        #10 reset = 1'b0;

    end

    always @(posedge clk) begin
        // Write seed value to file for each clock cycle
        $fwrite(handle3, "%h\n", seedInput);
    end

    // Check results on falling edge of clock
    always @(negedge clk) begin
        if (~reset) begin
            // Check if output repeated
            if (seed == seedInput) begin
                integer iterations;
                iterations = $time / 2; // Assuming clock period is 2
                $display("Output repeated after %d iterations", iterations);
                // Optionally stop simulation
                // $stop;
            end else begin
                $display("Output did not repeat within 2^n iterations");
            end
        end
    end

    // Close file handles at the end of simulation
    always @* begin
        if (seed == seedInput) begin
            $fclose(handle3);
            $fclose(desc3);
            $stop;
        end
    end

endmodule // stimulus


