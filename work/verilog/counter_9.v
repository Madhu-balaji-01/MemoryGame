/*
   This file was generated automatically by Alchitry Labs version 1.2.5.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     SIZE = 28
     DIV = 0
     TOP = 0
     UP = 1
*/
module counter_9 (
    input clk,
    input rst,
    output reg [27:0] value
  );
  
  localparam SIZE = 5'h1c;
  localparam DIV = 1'h0;
  localparam TOP = 1'h0;
  localparam UP = 1'h1;
  
  
  reg [27:0] M_ctr_d, M_ctr_q = 1'h0;
  
  localparam MAX_VALUE = 1'h0;
  
  always @* begin
    M_ctr_d = M_ctr_q;
    
    value = M_ctr_q;
    if (1'h1) begin
      M_ctr_d = M_ctr_q + 1'h1;
      if (1'h0 && M_ctr_q == 1'h0) begin
        M_ctr_d = 1'h0;
      end
    end else begin
      M_ctr_d = M_ctr_q - 1'h1;
      if (1'h0 && M_ctr_q == 1'h0) begin
        M_ctr_d = 1'h0;
      end
    end
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_ctr_q <= 1'h0;
    end else begin
      M_ctr_q <= M_ctr_d;
    end
  end
  
endmodule
