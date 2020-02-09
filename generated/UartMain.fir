;buildInfoPackage: chisel3, version: 3.2.2, scalaVersion: 2.11.12, sbtVersion: 1.3.2
circuit UartMain : 
  module Tx : 
    input clock : Clock
    input reset : Reset
    output io : {txd : UInt<1>, flip channel : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}
    
    reg shiftReg : UInt, clock with : (reset => (reset, UInt<11>("h07ff"))) @[Uart.scala 30:25]
    reg cntReg : UInt<20>, clock with : (reset => (reset, UInt<20>("h00"))) @[Uart.scala 31:23]
    reg bitsReg : UInt<4>, clock with : (reset => (reset, UInt<4>("h00"))) @[Uart.scala 32:24]
    node _T = eq(cntReg, UInt<1>("h00")) @[Uart.scala 34:31]
    node _T_1 = eq(bitsReg, UInt<1>("h00")) @[Uart.scala 34:52]
    node _T_2 = and(_T, _T_1) @[Uart.scala 34:40]
    io.channel.ready <= _T_2 @[Uart.scala 34:20]
    node _T_3 = bits(shiftReg, 0, 0) @[Uart.scala 35:21]
    io.txd <= _T_3 @[Uart.scala 35:10]
    node _T_4 = eq(cntReg, UInt<1>("h00")) @[Uart.scala 37:15]
    when _T_4 : @[Uart.scala 37:24]
      cntReg <= UInt<9>("h01b1") @[Uart.scala 39:12]
      node _T_5 = neq(bitsReg, UInt<1>("h00")) @[Uart.scala 40:18]
      when _T_5 : @[Uart.scala 40:27]
        node _T_6 = shr(shiftReg, 1) @[Uart.scala 41:28]
        node _T_7 = bits(_T_6, 9, 0) @[Uart.scala 42:33]
        node _T_8 = cat(UInt<1>("h01"), _T_7) @[Cat.scala 29:58]
        shiftReg <= _T_8 @[Uart.scala 42:16]
        node _T_9 = sub(bitsReg, UInt<1>("h01")) @[Uart.scala 43:26]
        node _T_10 = tail(_T_9, 1) @[Uart.scala 43:26]
        bitsReg <= _T_10 @[Uart.scala 43:15]
        skip @[Uart.scala 40:27]
      else : @[Uart.scala 44:17]
        when io.channel.valid : @[Uart.scala 45:30]
          node _T_11 = cat(UInt<2>("h03"), io.channel.bits) @[Cat.scala 29:58]
          node _T_12 = cat(_T_11, UInt<1>("h00")) @[Cat.scala 29:58]
          shiftReg <= _T_12 @[Uart.scala 46:18]
          bitsReg <= UInt<4>("h0b") @[Uart.scala 47:17]
          skip @[Uart.scala 45:30]
        else : @[Uart.scala 48:19]
          shiftReg <= UInt<11>("h07ff") @[Uart.scala 49:18]
          skip @[Uart.scala 48:19]
        skip @[Uart.scala 44:17]
      skip @[Uart.scala 37:24]
    else : @[Uart.scala 53:15]
      node _T_13 = sub(cntReg, UInt<1>("h01")) @[Uart.scala 54:22]
      node _T_14 = tail(_T_13, 1) @[Uart.scala 54:22]
      cntReg <= _T_14 @[Uart.scala 54:12]
      skip @[Uart.scala 53:15]
    
  module Buffer : 
    input clock : Clock
    input reset : Reset
    output io : {flip in : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, out : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}
    
    reg stateReg : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Uart.scala 116:25]
    reg dataReg : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[Uart.scala 117:24]
    node _T = eq(stateReg, UInt<1>("h00")) @[Uart.scala 119:27]
    io.in.ready <= _T @[Uart.scala 119:15]
    node _T_1 = eq(stateReg, UInt<1>("h01")) @[Uart.scala 120:28]
    io.out.valid <= _T_1 @[Uart.scala 120:16]
    node _T_2 = eq(stateReg, UInt<1>("h00")) @[Uart.scala 122:17]
    when _T_2 : @[Uart.scala 122:28]
      when io.in.valid : @[Uart.scala 123:23]
        dataReg <= io.in.bits @[Uart.scala 124:15]
        stateReg <= UInt<1>("h01") @[Uart.scala 125:16]
        skip @[Uart.scala 123:23]
      skip @[Uart.scala 122:28]
    else : @[Uart.scala 127:15]
      when io.out.ready : @[Uart.scala 128:24]
        stateReg <= UInt<1>("h00") @[Uart.scala 129:16]
        skip @[Uart.scala 128:24]
      skip @[Uart.scala 127:15]
    io.out.bits <= dataReg @[Uart.scala 132:15]
    
  module BufferedTx : 
    input clock : Clock
    input reset : Reset
    output io : {txd : UInt<1>, flip channel : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}
    
    inst tx of Tx @[Uart.scala 143:18]
    tx.clock <= clock
    tx.reset <= reset
    inst buf of Buffer @[Uart.scala 144:19]
    buf.clock <= clock
    buf.reset <= reset
    buf.io.in.bits <= io.channel.bits @[Uart.scala 146:13]
    buf.io.in.valid <= io.channel.valid @[Uart.scala 146:13]
    io.channel.ready <= buf.io.in.ready @[Uart.scala 146:13]
    tx.io.channel.bits <= buf.io.out.bits @[Uart.scala 147:17]
    tx.io.channel.valid <= buf.io.out.valid @[Uart.scala 147:17]
    buf.io.out.ready <= tx.io.channel.ready @[Uart.scala 147:17]
    io.txd <= tx.io.txd @[Uart.scala 148:10]
    
  module Sender : 
    input clock : Clock
    input reset : Reset
    output io : {txd : UInt<1>}
    
    inst tx of BufferedTx @[Uart.scala 159:18]
    tx.clock <= clock
    tx.reset <= reset
    io.txd <= tx.io.txd @[Uart.scala 161:10]
    wire text : UInt<7>[12] @[Uart.scala 164:21]
    text[0] <= UInt<7>("h048") @[Uart.scala 164:21]
    text[1] <= UInt<7>("h065") @[Uart.scala 164:21]
    text[2] <= UInt<7>("h06c") @[Uart.scala 164:21]
    text[3] <= UInt<7>("h06c") @[Uart.scala 164:21]
    text[4] <= UInt<7>("h06f") @[Uart.scala 164:21]
    text[5] <= UInt<6>("h020") @[Uart.scala 164:21]
    text[6] <= UInt<7>("h057") @[Uart.scala 164:21]
    text[7] <= UInt<7>("h06f") @[Uart.scala 164:21]
    text[8] <= UInt<7>("h072") @[Uart.scala 164:21]
    text[9] <= UInt<7>("h06c") @[Uart.scala 164:21]
    text[10] <= UInt<7>("h064") @[Uart.scala 164:21]
    text[11] <= UInt<6>("h021") @[Uart.scala 164:21]
    reg cntReg : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[Uart.scala 167:23]
    node _T = bits(cntReg, 3, 0)
    tx.io.channel.bits <= text[_T] @[Uart.scala 169:22]
    node _T_1 = neq(cntReg, UInt<4>("h0c")) @[Uart.scala 170:33]
    tx.io.channel.valid <= _T_1 @[Uart.scala 170:23]
    node _T_2 = neq(cntReg, UInt<4>("h0c")) @[Uart.scala 172:38]
    node _T_3 = and(tx.io.channel.ready, _T_2) @[Uart.scala 172:28]
    when _T_3 : @[Uart.scala 172:47]
      node _T_4 = add(cntReg, UInt<1>("h01")) @[Uart.scala 173:22]
      node _T_5 = tail(_T_4, 1) @[Uart.scala 173:22]
      cntReg <= _T_5 @[Uart.scala 173:12]
      skip @[Uart.scala 172:47]
    
  module UartMain : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip rxd : UInt<1>, txd : UInt<1>}
    
    inst Sender of Sender @[Uart.scala 199:19]
    Sender.clock <= clock
    Sender.reset <= reset
    io.txd <= Sender.io.txd @[Uart.scala 200:12]
    
