// tb_HelloWorld.v
`include "HelloWorld.v"

`timescale 1ns/1ps

module tb_HelloWorld;

  reg clk;
  wire [6:0] seg; // Change reg to wire
  wire dp;       // Change reg to wire
  wire [3:0] an;  // Change reg to wire

  // Instantiate your HelloWorld module
  HelloWorld uut (
    .seg(seg),
    .dp(dp),
    .an(an),
    .clk(clk)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Simulation code
  initial begin
    // Add any additional setup code here

    // Run the simulation for a period of time
    #1000 $finish;
  end

  // Display "hello world" in the console
  initial begin
    #10 $display("Hello World");
  end

  // Add any other testbench code here

endmodule
