module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
  reg [10:0] shiftReg; // @[Uart.scala 30:25]
  reg [31:0] _RAND_0;
  reg [19:0] cntReg; // @[Uart.scala 31:23]
  reg [31:0] _RAND_1;
  reg [3:0] bitsReg; // @[Uart.scala 32:24]
  reg [31:0] _RAND_2;
  wire  _T; // @[Uart.scala 34:31]
  wire  _T_1; // @[Uart.scala 34:52]
  wire  _T_5; // @[Uart.scala 40:18]
  wire [9:0] _T_6; // @[Uart.scala 41:28]
  wire [10:0] _T_8; // @[Cat.scala 29:58]
  wire [3:0] _T_10; // @[Uart.scala 43:26]
  wire [10:0] _T_12; // @[Cat.scala 29:58]
  wire [19:0] _T_14; // @[Uart.scala 54:22]
  assign _T = cntReg == 20'h0; // @[Uart.scala 34:31]
  assign _T_1 = bitsReg == 4'h0; // @[Uart.scala 34:52]
  assign _T_5 = bitsReg != 4'h0; // @[Uart.scala 40:18]
  assign _T_6 = shiftReg[10:1]; // @[Uart.scala 41:28]
  assign _T_8 = {1'h1,_T_6}; // @[Cat.scala 29:58]
  assign _T_10 = bitsReg - 4'h1; // @[Uart.scala 43:26]
  assign _T_12 = {2'h3,io_channel_bits,1'h0}; // @[Cat.scala 29:58]
  assign _T_14 = cntReg - 20'h1; // @[Uart.scala 54:22]
  assign io_txd = shiftReg[0]; // @[Uart.scala 35:10]
  assign io_channel_ready = _T & _T_1; // @[Uart.scala 34:20]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shiftReg = _RAND_0[10:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[19:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      shiftReg <= 11'h7ff;
    end else if (_T) begin
      if (_T_5) begin
        shiftReg <= _T_8;
      end else if (io_channel_valid) begin
        shiftReg <= _T_12;
      end else begin
        shiftReg <= 11'h7ff;
      end
    end
    if (reset) begin
      cntReg <= 20'h0;
    end else if (_T) begin
      cntReg <= 20'h1b1;
    end else begin
      cntReg <= _T_14;
    end
    if (reset) begin
      bitsReg <= 4'h0;
    end else if (_T) begin
      if (_T_5) begin
        bitsReg <= _T_10;
      end else if (io_channel_valid) begin
        bitsReg <= 4'hb;
      end
    end
  end
endmodule
module Buffer(
  input        clock,
  input        reset,
  output       io_in_ready,
  input        io_in_valid,
  input  [7:0] io_in_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits
);
  reg  stateReg; // @[Uart.scala 116:25]
  reg [31:0] _RAND_0;
  reg [7:0] dataReg; // @[Uart.scala 117:24]
  reg [31:0] _RAND_1;
  wire  _T; // @[Uart.scala 119:27]
  wire  _GEN_1; // @[Uart.scala 123:23]
  assign _T = stateReg == 1'h0; // @[Uart.scala 119:27]
  assign _GEN_1 = io_in_valid | stateReg; // @[Uart.scala 123:23]
  assign io_in_ready = stateReg == 1'h0; // @[Uart.scala 119:15]
  assign io_out_valid = stateReg; // @[Uart.scala 120:16]
  assign io_out_bits = dataReg; // @[Uart.scala 132:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 1'h0;
    end else if (_T) begin
      stateReg <= _GEN_1;
    end else if (io_out_ready) begin
      stateReg <= 1'h0;
    end
    if (reset) begin
      dataReg <= 8'h0;
    end else if (_T) begin
      if (io_in_valid) begin
        dataReg <= io_in_bits;
      end
    end
  end
endmodule
module BufferedTx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
  wire  tx_clock; // @[Uart.scala 143:18]
  wire  tx_reset; // @[Uart.scala 143:18]
  wire  tx_io_txd; // @[Uart.scala 143:18]
  wire  tx_io_channel_ready; // @[Uart.scala 143:18]
  wire  tx_io_channel_valid; // @[Uart.scala 143:18]
  wire [7:0] tx_io_channel_bits; // @[Uart.scala 143:18]
  wire  buf__clock; // @[Uart.scala 144:19]
  wire  buf__reset; // @[Uart.scala 144:19]
  wire  buf__io_in_ready; // @[Uart.scala 144:19]
  wire  buf__io_in_valid; // @[Uart.scala 144:19]
  wire [7:0] buf__io_in_bits; // @[Uart.scala 144:19]
  wire  buf__io_out_ready; // @[Uart.scala 144:19]
  wire  buf__io_out_valid; // @[Uart.scala 144:19]
  wire [7:0] buf__io_out_bits; // @[Uart.scala 144:19]
  Tx tx ( // @[Uart.scala 143:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  Buffer buf_ ( // @[Uart.scala 144:19]
    .clock(buf__clock),
    .reset(buf__reset),
    .io_in_ready(buf__io_in_ready),
    .io_in_valid(buf__io_in_valid),
    .io_in_bits(buf__io_in_bits),
    .io_out_ready(buf__io_out_ready),
    .io_out_valid(buf__io_out_valid),
    .io_out_bits(buf__io_out_bits)
  );
  assign io_txd = tx_io_txd; // @[Uart.scala 148:10]
  assign io_channel_ready = buf__io_in_ready; // @[Uart.scala 146:13]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = buf__io_out_valid; // @[Uart.scala 147:17]
  assign tx_io_channel_bits = buf__io_out_bits; // @[Uart.scala 147:17]
  assign buf__clock = clock;
  assign buf__reset = reset;
  assign buf__io_in_valid = io_channel_valid; // @[Uart.scala 146:13]
  assign buf__io_in_bits = io_channel_bits; // @[Uart.scala 146:13]
  assign buf__io_out_ready = tx_io_channel_ready; // @[Uart.scala 147:17]
endmodule
module Sender(
  input   clock,
  input   reset,
  output  io_txd
);
  wire  tx_clock; // @[Uart.scala 159:18]
  wire  tx_reset; // @[Uart.scala 159:18]
  wire  tx_io_txd; // @[Uart.scala 159:18]
  wire  tx_io_channel_ready; // @[Uart.scala 159:18]
  wire  tx_io_channel_valid; // @[Uart.scala 159:18]
  wire [7:0] tx_io_channel_bits; // @[Uart.scala 159:18]
  reg [7:0] cntReg; // @[Uart.scala 167:23]
  reg [31:0] _RAND_0;
  wire [3:0] _T;
  wire [6:0] _GEN_1; // @[Uart.scala 169:22]
  wire [6:0] _GEN_2; // @[Uart.scala 169:22]
  wire [6:0] _GEN_3; // @[Uart.scala 169:22]
  wire [6:0] _GEN_4; // @[Uart.scala 169:22]
  wire [6:0] _GEN_5; // @[Uart.scala 169:22]
  wire [6:0] _GEN_6; // @[Uart.scala 169:22]
  wire [6:0] _GEN_7; // @[Uart.scala 169:22]
  wire [6:0] _GEN_8; // @[Uart.scala 169:22]
  wire [6:0] _GEN_9; // @[Uart.scala 169:22]
  wire [6:0] _GEN_10; // @[Uart.scala 169:22]
  wire [6:0] _GEN_11; // @[Uart.scala 169:22]
  wire  _T_1; // @[Uart.scala 170:33]
  wire  _T_3; // @[Uart.scala 172:28]
  wire [7:0] _T_5; // @[Uart.scala 173:22]
  BufferedTx tx ( // @[Uart.scala 159:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_txd(tx_io_txd),
    .io_channel_ready(tx_io_channel_ready),
    .io_channel_valid(tx_io_channel_valid),
    .io_channel_bits(tx_io_channel_bits)
  );
  assign _T = cntReg[3:0];
  assign _GEN_1 = 4'h1 == _T ? 7'h65 : 7'h48; // @[Uart.scala 169:22]
  assign _GEN_2 = 4'h2 == _T ? 7'h6c : _GEN_1; // @[Uart.scala 169:22]
  assign _GEN_3 = 4'h3 == _T ? 7'h6c : _GEN_2; // @[Uart.scala 169:22]
  assign _GEN_4 = 4'h4 == _T ? 7'h6f : _GEN_3; // @[Uart.scala 169:22]
  assign _GEN_5 = 4'h5 == _T ? 7'h20 : _GEN_4; // @[Uart.scala 169:22]
  assign _GEN_6 = 4'h6 == _T ? 7'h57 : _GEN_5; // @[Uart.scala 169:22]
  assign _GEN_7 = 4'h7 == _T ? 7'h6f : _GEN_6; // @[Uart.scala 169:22]
  assign _GEN_8 = 4'h8 == _T ? 7'h72 : _GEN_7; // @[Uart.scala 169:22]
  assign _GEN_9 = 4'h9 == _T ? 7'h6c : _GEN_8; // @[Uart.scala 169:22]
  assign _GEN_10 = 4'ha == _T ? 7'h64 : _GEN_9; // @[Uart.scala 169:22]
  assign _GEN_11 = 4'hb == _T ? 7'h21 : _GEN_10; // @[Uart.scala 169:22]
  assign _T_1 = cntReg != 8'hc; // @[Uart.scala 170:33]
  assign _T_3 = tx_io_channel_ready & _T_1; // @[Uart.scala 172:28]
  assign _T_5 = cntReg + 8'h1; // @[Uart.scala 173:22]
  assign io_txd = tx_io_txd; // @[Uart.scala 161:10]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_channel_valid = cntReg != 8'hc; // @[Uart.scala 170:23]
  assign tx_io_channel_bits = {{1'd0}, _GEN_11}; // @[Uart.scala 169:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cntReg = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      cntReg <= 8'h0;
    end else if (_T_3) begin
      cntReg <= _T_5;
    end
  end
endmodule
module UartMain(
  input   clock,
  input   reset,
  input   io_rxd,
  output  io_txd
);
  wire  Sender_clock; // @[Uart.scala 199:19]
  wire  Sender_reset; // @[Uart.scala 199:19]
  wire  Sender_io_txd; // @[Uart.scala 199:19]
  Sender Sender ( // @[Uart.scala 199:19]
    .clock(Sender_clock),
    .reset(Sender_reset),
    .io_txd(Sender_io_txd)
  );
  assign io_txd = Sender_io_txd; // @[Uart.scala 200:12]
  assign Sender_clock = clock;
  assign Sender_reset = reset;
endmodule
