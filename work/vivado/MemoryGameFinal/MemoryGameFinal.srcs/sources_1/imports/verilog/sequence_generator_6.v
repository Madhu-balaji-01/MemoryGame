/*
   This file was generated automatically by Alchitry Labs version 1.2.5.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module sequence_generator_6 (
    input clk,
    input rst,
    input [15:0] stage,
    output reg [24:0] seq
  );
  
  
  
  wire [1-1:0] M_edge_detector_rng_out;
  reg [1-1:0] M_edge_detector_rng_in;
  edge_detector_10 edge_detector_rng (
    .clk(clk),
    .in(M_edge_detector_rng_in),
    .out(M_edge_detector_rng_out)
  );
  wire [1-1:0] M_slowClock_value;
  counter_11 slowClock (
    .clk(clk),
    .rst(rst),
    .value(M_slowClock_value)
  );
  reg [15:0] M_seed_d, M_seed_q = 1'h0;
  wire [32-1:0] M_pn_gen_num;
  reg [1-1:0] M_pn_gen_next;
  reg [32-1:0] M_pn_gen_seed;
  pn_gen_12 pn_gen (
    .clk(clk),
    .rst(rst),
    .next(M_pn_gen_next),
    .seed(M_pn_gen_seed),
    .num(M_pn_gen_num)
  );
  
  reg [1:0] random_num;
  
  localparam LEVEL3 = 96'h814824214181418842141228;
  
  localparam LEVEL2 = 80'h18482824412184842841;
  
  localparam LEVEL1 = 64'h8281241841811284;
  
  always @* begin
    M_seed_d = M_seed_q;
    
    M_pn_gen_seed = M_seed_q;
    M_edge_detector_rng_in = M_slowClock_value;
    M_pn_gen_next = M_edge_detector_rng_out;
    random_num = M_pn_gen_num[0+1-:2];
    
    case (stage[0+1-:2])
      1'h1: begin
        seq = LEVEL1[(random_num)*16+15-:16];
      end
      4'ha: begin
        seq = LEVEL2[(random_num)*20+19-:20];
      end
      4'hb: begin
        seq = LEVEL3[(random_num)*24+23-:24];
      end
      default: begin
        seq = 16'h0000;
      end
    endcase
    M_seed_d = M_seed_q + 1'h1;
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_seed_q <= 1'h0;
    end else begin
      M_seed_q <= M_seed_d;
    end
  end
  
endmodule
