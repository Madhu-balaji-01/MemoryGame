/*
   This file was generated automatically by Alchitry Labs version 1.2.5.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module gameplay_4 (
    input clk,
    input rst,
    input [5:0] buttons,
    output reg red,
    output reg green,
    output reg blue,
    output reg yellow,
    output reg [3:0] status_sel,
    output reg [6:0] status_seg,
    output reg [3:0] lives_sel,
    output reg [6:0] lives_seg,
    output reg [23:0] io_led
  );
  
  
  
  wire [25-1:0] M_seq_gen_seq;
  reg [16-1:0] M_seq_gen_stage;
  sequence_generator_6 seq_gen (
    .clk(clk),
    .rst(rst),
    .stage(M_seq_gen_stage),
    .seq(M_seq_gen_seq)
  );
  wire [2-1:0] M_check_seq_check_result;
  reg [16-1:0] M_check_seq_stage;
  reg [25-1:0] M_check_seq_inp_seq;
  reg [25-1:0] M_check_seq_correct_seq;
  check_sequence_7 check_seq (
    .clk(clk),
    .rst(rst),
    .stage(M_check_seq_stage),
    .inp_seq(M_check_seq_inp_seq),
    .correct_seq(M_check_seq_correct_seq),
    .check_result(M_check_seq_check_result)
  );
  wire [7-1:0] M_lives_disp_seg;
  wire [4-1:0] M_lives_disp_sel;
  reg [32-1:0] M_lives_disp_values;
  multi_seven_seg_8 lives_disp (
    .clk(clk),
    .rst(rst),
    .values(M_lives_disp_values),
    .seg(M_lives_disp_seg),
    .sel(M_lives_disp_sel)
  );
  wire [7-1:0] M_status_disp_seg;
  wire [4-1:0] M_status_disp_sel;
  reg [32-1:0] M_status_disp_values;
  multi_seven_seg_8 status_disp (
    .clk(clk),
    .rst(rst),
    .values(M_status_disp_values),
    .seg(M_status_disp_seg),
    .sel(M_status_disp_sel)
  );
  wire [28-1:0] M_slowClock_game_value;
  counter_9 slowClock_game (
    .clk(clk),
    .rst(rst),
    .value(M_slowClock_game_value)
  );
  localparam START_gameMachine = 5'd0;
  localparam UPDATE_SETTINGS_gameMachine = 5'd1;
  localparam GENERATE_gameMachine = 5'd2;
  localparam DISPLAY_CLR1_gameMachine = 5'd3;
  localparam DISPLAY_CLR2_gameMachine = 5'd4;
  localparam DISPLAY_CLR3_gameMachine = 5'd5;
  localparam DISPLAY_CLR4_gameMachine = 5'd6;
  localparam DISPLAY_CLR5_gameMachine = 5'd7;
  localparam DISPLAY_CLR6_gameMachine = 5'd8;
  localparam STORE_gameMachine = 5'd9;
  localparam CHECK_gameMachine = 5'd10;
  localparam PASS_STAGE_gameMachine = 5'd11;
  localparam WIN_GAME_gameMachine = 5'd12;
  localparam FAIL_STAGE_gameMachine = 5'd13;
  localparam LOSE_GAME_gameMachine = 5'd14;
  localparam RESET_gameMachine = 5'd15;
  localparam NEXT_gameMachine = 5'd16;
  
  reg [4:0] M_gameMachine_d, M_gameMachine_q = START_gameMachine;
  reg [2:0] M_button_count_d, M_button_count_q = 1'h0;
  reg [24:0] M_seq_store_d, M_seq_store_q = 1'h0;
  reg [1:0] M_new_level_d, M_new_level_q = 1'h0;
  reg [24:0] M_sequence_d, M_sequence_q = 1'h0;
  reg [1:0] M_life_var_d, M_life_var_q = 1'h0;
  reg [1:0] M_check_result_d, M_check_result_q = 1'h0;
  
  wire [1-1:0] M_slowClockEdge_1_out;
  reg [1-1:0] M_slowClockEdge_1_in;
  edge_detector_3 slowClockEdge_1 (
    .clk(clk),
    .in(M_slowClockEdge_1_in),
    .out(M_slowClockEdge_1_out)
  );
  
  always @* begin
    M_gameMachine_d = M_gameMachine_q;
    M_sequence_d = M_sequence_q;
    M_life_var_d = M_life_var_q;
    M_check_result_d = M_check_result_q;
    M_new_level_d = M_new_level_q;
    M_button_count_d = M_button_count_q;
    M_seq_store_d = M_seq_store_q;
    
    io_led = 24'h000000;
    M_slowClockEdge_1_in = M_slowClock_game_value[27+0-:1];
    red = 4'h0;
    blue = 4'h0;
    green = 4'h0;
    yellow = 4'h0;
    M_life_var_d = 2'h3;
    M_seq_gen_stage = M_new_level_q;
    M_check_seq_inp_seq = M_seq_store_q;
    M_check_seq_stage = M_new_level_q;
    M_check_seq_correct_seq = M_sequence_q;
    lives_sel = M_lives_disp_sel;
    lives_seg = ~M_lives_disp_seg;
    M_status_disp_values = 32'h09090909;
    status_sel = M_status_disp_sel;
    status_seg = ~M_status_disp_seg;
    M_new_level_d = M_new_level_q;
    
    case (M_gameMachine_q)
      START_gameMachine: begin
        green = 4'h1;
        M_new_level_d = 2'h1;
        M_status_disp_values = 32'h080c0a0e;
        if (M_life_var_q == 2'h3) begin
          M_lives_disp_values = 32'h03090909;
        end else begin
          if (M_life_var_q == 2'h2) begin
            M_lives_disp_values = 32'h09090902;
          end else begin
            M_lives_disp_values = 32'h09090901;
          end
        end
        if (buttons[4+0-:1]) begin
          M_gameMachine_d = GENERATE_gameMachine;
        end
      end
      GENERATE_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        M_button_count_d = 3'h0;
        M_seq_store_d = 25'h0000000;
        M_seq_gen_stage = M_new_level_q;
        M_sequence_d = M_seq_gen_seq;
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = DISPLAY_CLR1_gameMachine;
        end
      end
      DISPLAY_CLR1_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        
        case (M_sequence_q[0+3-:4])
          4'h8: begin
            red = 1'h1;
          end
          4'h4: begin
            green = 1'h1;
          end
          4'ha: begin
            blue = 1'h1;
          end
          4'h1: begin
            yellow = 1'h1;
          end
        endcase
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = DISPLAY_CLR2_gameMachine;
        end
      end
      DISPLAY_CLR2_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        
        case (M_sequence_q[4+3-:4])
          4'h8: begin
            red = 4'h1;
          end
          4'h4: begin
            green = 4'h1;
          end
          4'ha: begin
            blue = 4'h1;
          end
          4'h1: begin
            yellow = 4'h1;
          end
        endcase
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = DISPLAY_CLR3_gameMachine;
        end
      end
      DISPLAY_CLR3_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        
        case (M_sequence_q[8+3-:4])
          4'h8: begin
            red = 4'h1;
          end
          4'h4: begin
            green = 4'h1;
          end
          4'ha: begin
            blue = 4'h1;
          end
          4'h1: begin
            yellow = 4'h1;
          end
        endcase
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = DISPLAY_CLR4_gameMachine;
        end
      end
      DISPLAY_CLR4_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        
        case (M_sequence_q[12+3-:4])
          4'h8: begin
            red = 4'h1;
          end
          4'h4: begin
            green = 4'h1;
          end
          4'ha: begin
            blue = 4'h1;
          end
          4'h1: begin
            yellow = 4'h1;
          end
        endcase
        if (M_slowClockEdge_1_out == 1'h1) begin
          if (M_new_level_q == 2'h1) begin
            M_gameMachine_d = STORE_gameMachine;
          end else begin
            M_gameMachine_d = DISPLAY_CLR5_gameMachine;
          end
        end
      end
      DISPLAY_CLR5_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        
        case (M_sequence_q[16+3-:4])
          4'h8: begin
            red = 4'h1;
          end
          4'h4: begin
            green = 4'h1;
          end
          4'ha: begin
            blue = 4'h1;
          end
          4'h1: begin
            yellow = 4'h1;
          end
        endcase
        if (M_slowClockEdge_1_out == 1'h1) begin
          if (M_new_level_q == 2'h2) begin
            M_gameMachine_d = STORE_gameMachine;
          end else begin
            M_gameMachine_d = DISPLAY_CLR6_gameMachine;
          end
        end
      end
      DISPLAY_CLR6_gameMachine: begin
        M_status_disp_values = 32'h080c0a0e;
        io_led[0+0+2-:3] = M_new_level_q;
        io_led[8+0+2-:3] = M_life_var_q;
        
        case (M_sequence_q[20+3-:4])
          4'h8: begin
            red = 4'h1;
          end
          4'h4: begin
            green = 4'h1;
          end
          4'ha: begin
            blue = 4'h1;
          end
          4'h1: begin
            yellow = 4'h1;
          end
        endcase
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = STORE_gameMachine;
        end
      end
      STORE_gameMachine: begin
        io_led[0+7-:8] = M_seq_store_q[0+7-:8];
        io_led[8+7-:8] = M_seq_store_q[8+7-:8];
        io_led[16+7-:8] = M_seq_store_q[16+7-:8];
        if (buttons[3+0-:1] | buttons[2+0-:1] | buttons[1+0-:1] | buttons[0+0-:1]) begin
          M_button_count_d = M_button_count_q + 1'h1;
          
          case (M_button_count_q)
            3'h0: begin
              if (buttons[3+0-:1] == 1'h1) begin
                M_seq_store_d[0+3-:4] = 10'h3e8;
              end else begin
                if (buttons[2+0-:1] == 1'h1) begin
                  M_seq_store_d[0+3-:4] = 7'h64;
                end else begin
                  if (buttons[1+0-:1] == 1'h1) begin
                    M_seq_store_d[0+3-:4] = 4'ha;
                  end else begin
                    if (buttons[0+0-:1] == 1'h1) begin
                      M_seq_store_d[0+3-:4] = 1'h1;
                    end
                  end
                end
              end
            end
            3'h1: begin
              if (buttons[3+0-:1] == 1'h1) begin
                M_seq_store_d[4+3-:4] = 10'h3e8;
              end else begin
                if (buttons[2+0-:1] == 1'h1) begin
                  M_seq_store_d[4+3-:4] = 7'h64;
                end else begin
                  if (buttons[1+0-:1] == 1'h1) begin
                    M_seq_store_d[4+3-:4] = 4'ha;
                  end else begin
                    if (buttons[0+0-:1] == 1'h1) begin
                      M_seq_store_d[4+3-:4] = 1'h1;
                    end
                  end
                end
              end
            end
            3'h2: begin
              if (buttons[3+0-:1] == 1'h1) begin
                M_seq_store_d[8+3-:4] = 10'h3e8;
              end else begin
                if (buttons[2+0-:1] == 1'h1) begin
                  M_seq_store_d[8+3-:4] = 7'h64;
                end else begin
                  if (buttons[1+0-:1] == 1'h1) begin
                    M_seq_store_d[8+3-:4] = 4'ha;
                  end else begin
                    if (buttons[0+0-:1] == 1'h1) begin
                      M_seq_store_d[8+3-:4] = 1'h1;
                    end
                  end
                end
              end
            end
            3'h3: begin
              if (buttons[3+0-:1] == 1'h1) begin
                M_seq_store_d[12+3-:4] = 10'h3e8;
              end else begin
                if (buttons[2+0-:1] == 1'h1) begin
                  M_seq_store_d[12+3-:4] = 7'h64;
                end else begin
                  if (buttons[1+0-:1] == 1'h1) begin
                    M_seq_store_d[12+3-:4] = 4'ha;
                  end else begin
                    if (buttons[0+0-:1] == 1'h1) begin
                      M_seq_store_d[12+3-:4] = 1'h1;
                    end
                  end
                end
              end
            end
            3'h4: begin
              if (buttons[3+0-:1] == 1'h1) begin
                M_seq_store_d[16+3-:4] = 10'h3e8;
              end else begin
                if (buttons[2+0-:1] == 1'h1) begin
                  M_seq_store_d[16+3-:4] = 7'h64;
                end else begin
                  if (buttons[1+0-:1] == 1'h1) begin
                    M_seq_store_d[16+3-:4] = 4'ha;
                  end else begin
                    if (buttons[0+0-:1] == 1'h1) begin
                      M_seq_store_d[16+3-:4] = 1'h1;
                    end
                  end
                end
              end
            end
            3'h5: begin
              if (buttons[3+0-:1] == 1'h1) begin
                M_seq_store_d[20+3-:4] = 10'h3e8;
              end else begin
                if (buttons[2+0-:1] == 1'h1) begin
                  M_seq_store_d[20+3-:4] = 7'h64;
                end else begin
                  if (buttons[1+0-:1] == 1'h1) begin
                    M_seq_store_d[20+3-:4] = 4'ha;
                  end else begin
                    if (buttons[0+0-:1] == 1'h1) begin
                      M_seq_store_d[20+3-:4] = 1'h1;
                    end
                  end
                end
              end
            end
          endcase
        end
        if (M_button_count_q == 3'h4 & M_new_level_q == 2'h1) begin
          M_gameMachine_d = CHECK_gameMachine;
        end else begin
          if (M_button_count_q == 3'h5 & M_new_level_q == 2'h2) begin
            M_gameMachine_d = CHECK_gameMachine;
          end else begin
            if (M_button_count_q == 3'h6 & M_new_level_q == 2'h3) begin
              M_gameMachine_d = CHECK_gameMachine;
            end else begin
              M_gameMachine_d = STORE_gameMachine;
            end
          end
        end
      end
      CHECK_gameMachine: begin
        M_check_seq_inp_seq = M_seq_store_q;
        M_check_seq_correct_seq = M_sequence_q;
        M_check_result_d = M_check_seq_check_result;
        if (M_slowClockEdge_1_out == 1'h1) begin
          if (M_check_result_q[0+0-:1]) begin
            M_gameMachine_d = PASS_STAGE_gameMachine;
          end else begin
            M_gameMachine_d = FAIL_STAGE_gameMachine;
          end
        end
      end
      PASS_STAGE_gameMachine: begin
        M_status_disp_values = 32'h05050c0e;
        if (M_slowClockEdge_1_out == 1'h1) begin
          if (M_new_level_q == 2'h3) begin
            M_gameMachine_d = WIN_GAME_gameMachine;
          end else begin
            if (M_new_level_q == 1'h1) begin
              M_new_level_d = 4'ha;
            end else begin
              if (M_new_level_q == 4'ha) begin
                M_new_level_d = 4'hb;
              end
            end
            M_gameMachine_d = NEXT_gameMachine;
          end
        end
      end
      FAIL_STAGE_gameMachine: begin
        if (M_life_var_q == 2'h1) begin
          M_gameMachine_d = LOSE_GAME_gameMachine;
        end
        M_status_disp_values = 32'h0a010c0b;
        M_life_var_d = M_life_var_q - 1'h1;
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = NEXT_gameMachine;
        end
      end
      NEXT_gameMachine: begin
        if (buttons[5+0-:1] == 1'h1) begin
          if (M_new_level_q == 2'h1) begin
            M_new_level_d = 2'h2;
          end else begin
            if (M_new_level_q == 2'h2) begin
              M_new_level_d = 2'h3;
            end
          end
          M_gameMachine_d = GENERATE_gameMachine;
        end else begin
          if (buttons[4+0-:1]) begin
            M_gameMachine_d = RESET_gameMachine;
          end
        end
      end
      WIN_GAME_gameMachine: begin
        green = 1'h1;
        blue = 1'h1;
        M_status_disp_values = 32'h080c0809;
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = RESET_gameMachine;
        end
      end
      LOSE_GAME_gameMachine: begin
        red = 1'h1;
        yellow = 1'h1;
        M_status_disp_values = 32'h0d070600;
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = RESET_gameMachine;
        end
      end
      RESET_gameMachine: begin
        M_life_var_d = 2'h3;
        M_new_level_d = 2'h1;
        M_button_count_d = 3'h0;
        M_sequence_d = 25'h0000000;
        if (M_slowClockEdge_1_out == 1'h1) begin
          M_gameMachine_d = START_gameMachine;
        end
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_button_count_q <= 1'h0;
      M_seq_store_q <= 1'h0;
      M_new_level_q <= 1'h0;
      M_sequence_q <= 1'h0;
      M_life_var_q <= 1'h0;
      M_check_result_q <= 1'h0;
      M_gameMachine_q <= 1'h0;
    end else begin
      M_button_count_q <= M_button_count_d;
      M_seq_store_q <= M_seq_store_d;
      M_new_level_q <= M_new_level_d;
      M_sequence_q <= M_sequence_d;
      M_life_var_q <= M_life_var_d;
      M_check_result_q <= M_check_result_d;
      M_gameMachine_q <= M_gameMachine_d;
    end
  end
  
endmodule
