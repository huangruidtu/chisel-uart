module Hello( // @[:@94.2]
  input   clock, // @[:@95.4]
  input   reset, // @[:@96.4]
  output  io_led, // @[:@97.4]
  output  io_txd // @[:@97.4]
);
  reg [31:0] cntReg; // @[Uart.scala 221:23:@102.4]
  reg [31:0] _RAND_0;
  reg  blkReg; // @[Uart.scala 222:23:@103.4]
  reg [31:0] _RAND_1;
  wire [32:0] _T_18; // @[Uart.scala 237:20:@109.4]
  wire [31:0] _T_19; // @[Uart.scala 237:20:@110.4]
  wire  _T_20; // @[Uart.scala 238:15:@112.4]
  wire  _T_22; // @[Uart.scala 240:15:@115.6]
  wire [31:0] _GEN_0; // @[Uart.scala 238:28:@113.4]
  wire  _GEN_1; // @[Uart.scala 238:28:@113.4]
  wire  value; // @[Uart.scala 238:28:@113.4]
  wire  _T_24; // @[Uart.scala 245:14:@119.4]
  assign _T_18 = cntReg + 32'h1; // @[Uart.scala 237:20:@109.4]
  assign _T_19 = cntReg + 32'h1; // @[Uart.scala 237:20:@110.4]
  assign _T_20 = cntReg == 32'h17d783f; // @[Uart.scala 238:15:@112.4]
  assign _T_22 = ~ blkReg; // @[Uart.scala 240:15:@115.6]
  assign _GEN_0 = _T_20 ? 32'h0 : _T_19; // @[Uart.scala 238:28:@113.4]
  assign _GEN_1 = _T_20 ? _T_22 : blkReg; // @[Uart.scala 238:28:@113.4]
  assign value = _T_20 ? blkReg : 1'h0; // @[Uart.scala 238:28:@113.4]
  assign _T_24 = value == 1'h0; // @[Uart.scala 245:14:@119.4]
  assign io_led = blkReg; // @[Uart.scala 251:10:@124.4]
  assign io_txd = _T_24 ? 1'h0 : 1'h1; // @[Uart.scala 233:10:@108.4 Uart.scala 248:10:@123.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cntReg = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  blkReg = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      cntReg <= 32'h0;
    end else begin
      if (_T_20) begin
        cntReg <= 32'h0;
      end else begin
        cntReg <= _T_19;
      end
    end
    if (reset) begin
      blkReg <= 1'h0;
    end else begin
      if (_T_20) begin
        blkReg <= _T_22;
      end
    end
  end
endmodule
module UartMain( // @[:@150.2]
  input   clock, // @[:@151.4]
  input   reset, // @[:@152.4]
  input   io_rxd, // @[:@153.4]
  output  io_txd, // @[:@153.4]
  output  io_led // @[:@153.4]
);
  wire  Hello_clock; // @[Uart.scala 283:19:@155.4]
  wire  Hello_reset; // @[Uart.scala 283:19:@155.4]
  wire  Hello_io_led; // @[Uart.scala 283:19:@155.4]
  wire  Hello_io_txd; // @[Uart.scala 283:19:@155.4]
  Hello Hello ( // @[Uart.scala 283:19:@155.4]
    .clock(Hello_clock),
    .reset(Hello_reset),
    .io_led(Hello_io_led),
    .io_txd(Hello_io_txd)
  );
  assign io_txd = Hello_io_txd; // @[Uart.scala 286:12:@159.4]
  assign io_led = Hello_io_led; // @[Uart.scala 285:12:@158.4]
  assign Hello_clock = clock; // @[:@156.4]
  assign Hello_reset = reset; // @[:@157.4]
endmodule
