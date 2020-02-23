;buildInfoPackage: chisel3, version: 3.1.8, scalaVersion: 2.11.12, sbtVersion: 1.1.1, builtAtString: 2019-07-08 17:44:42.884, builtAtMillis: 1562607882884
circuit UartMain : 
  module Tx : 
    input clock : Clock
    input reset : UInt<1>
    output io : {txd : UInt<1>, channel : {flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}}
    
    reg shiftReg : UInt, clock with : (reset => (reset, UInt<11>("h07ff"))) @[Uart.scala 34:25]
    reg cntReg : UInt<20>, clock with : (reset => (reset, UInt<20>("h00"))) @[Uart.scala 35:23]
    reg bitsReg : UInt<4>, clock with : (reset => (reset, UInt<4>("h00"))) @[Uart.scala 36:24]
    node _T_20 = eq(cntReg, UInt<1>("h00")) @[Uart.scala 38:31]
    node _T_22 = eq(bitsReg, UInt<1>("h00")) @[Uart.scala 38:52]
    node _T_23 = and(_T_20, _T_22) @[Uart.scala 38:40]
    io.channel.ready <= _T_23 @[Uart.scala 38:20]
    node _T_24 = bits(shiftReg, 0, 0) @[Uart.scala 39:21]
    io.txd <= _T_24 @[Uart.scala 39:10]
    node _T_26 = eq(cntReg, UInt<1>("h00")) @[Uart.scala 41:15]
    when _T_26 : @[Uart.scala 41:24]
      cntReg <= UInt<9>("h01b1") @[Uart.scala 43:12]
      node _T_28 = neq(bitsReg, UInt<1>("h00")) @[Uart.scala 44:18]
      when _T_28 : @[Uart.scala 44:27]
        node _T_29 = shr(shiftReg, 1) @[Uart.scala 45:28]
        node _T_31 = bits(_T_29, 9, 0) @[Uart.scala 46:33]
        node _T_32 = cat(UInt<1>("h01"), _T_31) @[Cat.scala 30:58]
        shiftReg <= _T_32 @[Uart.scala 46:16]
        node _T_34 = sub(bitsReg, UInt<1>("h01")) @[Uart.scala 47:26]
        node _T_35 = asUInt(_T_34) @[Uart.scala 47:26]
        node _T_36 = tail(_T_35, 1) @[Uart.scala 47:26]
        bitsReg <= _T_36 @[Uart.scala 47:15]
        skip @[Uart.scala 44:27]
      else : @[Uart.scala 48:17]
        when io.channel.valid : @[Uart.scala 49:30]
          node _T_38 = cat(UInt<2>("h03"), io.channel.data) @[Cat.scala 30:58]
          node _T_40 = cat(_T_38, UInt<1>("h00")) @[Cat.scala 30:58]
          shiftReg <= _T_40 @[Uart.scala 50:18]
          bitsReg <= UInt<4>("h0b") @[Uart.scala 51:17]
          skip @[Uart.scala 49:30]
        else : @[Uart.scala 52:19]
          shiftReg <= UInt<11>("h07ff") @[Uart.scala 53:18]
          skip @[Uart.scala 52:19]
        skip @[Uart.scala 48:17]
      skip @[Uart.scala 41:24]
    else : @[Uart.scala 57:15]
      node _T_44 = sub(cntReg, UInt<1>("h01")) @[Uart.scala 58:22]
      node _T_45 = asUInt(_T_44) @[Uart.scala 58:22]
      node _T_46 = tail(_T_45, 1) @[Uart.scala 58:22]
      cntReg <= _T_46 @[Uart.scala 58:12]
      skip @[Uart.scala 57:15]
    
  module Buffer : 
    input clock : Clock
    input reset : UInt<1>
    output io : {in : {flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}, flip out : {flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}}
    
    reg stateReg : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Uart.scala 120:25]
    reg dataReg : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[Uart.scala 121:24]
    node _T_28 = eq(stateReg, UInt<1>("h00")) @[Uart.scala 123:27]
    io.in.ready <= _T_28 @[Uart.scala 123:15]
    node _T_29 = eq(stateReg, UInt<1>("h01")) @[Uart.scala 124:28]
    io.out.valid <= _T_29 @[Uart.scala 124:16]
    node _T_30 = eq(stateReg, UInt<1>("h00")) @[Uart.scala 126:17]
    when _T_30 : @[Uart.scala 126:28]
      when io.in.valid : @[Uart.scala 127:23]
        dataReg <= io.in.data @[Uart.scala 128:15]
        stateReg <= UInt<1>("h01") @[Uart.scala 129:16]
        skip @[Uart.scala 127:23]
      skip @[Uart.scala 126:28]
    else : @[Uart.scala 131:15]
      when io.out.ready : @[Uart.scala 132:24]
        stateReg <= UInt<1>("h00") @[Uart.scala 133:16]
        skip @[Uart.scala 132:24]
      skip @[Uart.scala 131:15]
    io.out.data <= dataReg @[Uart.scala 136:15]
    
  module BufferedTx : 
    input clock : Clock
    input reset : UInt<1>
    output io : {txd : UInt<1>, channel : {flip data : UInt<8>, ready : UInt<1>, flip valid : UInt<1>}}
    
    inst tx of Tx @[Uart.scala 147:18]
    tx.clock <= clock
    tx.reset <= reset
    inst buf of Buffer @[Uart.scala 148:19]
    buf.clock <= clock
    buf.reset <= reset
    buf.io.in.valid <= io.channel.valid @[Uart.scala 150:13]
    io.channel.ready <= buf.io.in.ready @[Uart.scala 150:13]
    buf.io.in.data <= io.channel.data @[Uart.scala 150:13]
    tx.io.channel.valid <= buf.io.out.valid @[Uart.scala 151:17]
    buf.io.out.ready <= tx.io.channel.ready @[Uart.scala 151:17]
    tx.io.channel.data <= buf.io.out.data @[Uart.scala 151:17]
    io.txd <= tx.io.txd @[Uart.scala 152:10]
    
  module Hello : 
    input clock : Clock
    input reset : UInt<1>
    output io : {led : UInt<1>, txd : UInt<1>}
    
    inst tx of BufferedTx @[Uart.scala 219:18]
    tx.clock <= clock
    tx.reset <= reset
    reg cntReg : UInt<32>, clock with : (reset => (reset, UInt<32>("h00"))) @[Uart.scala 221:23]
    reg blkReg : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Uart.scala 222:23]
    wire value : UInt @[Uart.scala 224:19]
    wire msg : UInt @[Uart.scala 225:17]
    value <= UInt<1>("h00") @[Uart.scala 226:9]
    msg <= UInt<1>("h01") @[Uart.scala 227:7]
    io.txd <= tx.io.txd @[Uart.scala 233:10]
    node _T_18 = add(cntReg, UInt<1>("h01")) @[Uart.scala 237:20]
    node _T_19 = tail(_T_18, 1) @[Uart.scala 237:20]
    cntReg <= _T_19 @[Uart.scala 237:10]
    node _T_20 = eq(cntReg, UInt<25>("h017d783f")) @[Uart.scala 238:15]
    when _T_20 : @[Uart.scala 238:28]
      cntReg <= UInt<1>("h00") @[Uart.scala 239:12]
      node _T_22 = not(blkReg) @[Uart.scala 240:15]
      blkReg <= _T_22 @[Uart.scala 240:12]
      value <= blkReg @[Uart.scala 242:11]
      skip @[Uart.scala 238:28]
    node _T_24 = eq(value, UInt<1>("h00")) @[Uart.scala 245:14]
    when _T_24 : @[Uart.scala 245:22]
      msg <= UInt<1>("h00") @[Uart.scala 246:13]
      skip @[Uart.scala 245:22]
    io.txd <= msg @[Uart.scala 248:10]
    io.led <= blkReg @[Uart.scala 251:10]
    wire text : UInt<7>[11] @[Uart.scala 257:21]
    text[0] <= UInt<7>("h048") @[Uart.scala 257:21]
    text[1] <= UInt<7>("h065") @[Uart.scala 257:21]
    text[2] <= UInt<7>("h06c") @[Uart.scala 257:21]
    text[3] <= UInt<7>("h06c") @[Uart.scala 257:21]
    text[4] <= UInt<7>("h06f") @[Uart.scala 257:21]
    text[5] <= UInt<6>("h02c") @[Uart.scala 257:21]
    text[6] <= UInt<7>("h057") @[Uart.scala 257:21]
    text[7] <= UInt<7>("h06f") @[Uart.scala 257:21]
    text[8] <= UInt<7>("h072") @[Uart.scala 257:21]
    text[9] <= UInt<7>("h06c") @[Uart.scala 257:21]
    text[10] <= UInt<7>("h064") @[Uart.scala 257:21]
    reg cntReg_send : UInt<8>, clock with : (reset => (reset, UInt<8>("h00"))) @[Uart.scala 261:28]
    node _T_56 = bits(cntReg_send, 3, 0)
    tx.io.channel.data <= text[_T_56] @[Uart.scala 263:22]
    node _T_57 = neq(cntReg, UInt<4>("h0b")) @[Uart.scala 264:33]
    tx.io.channel.valid <= _T_57 @[Uart.scala 264:23]
    node _T_58 = neq(cntReg_send, UInt<4>("h0b")) @[Uart.scala 266:43]
    node _T_59 = and(tx.io.channel.ready, _T_58) @[Uart.scala 266:28]
    when _T_59 : @[Uart.scala 266:52]
      node _T_61 = add(cntReg_send, UInt<1>("h01")) @[Uart.scala 267:32]
      node _T_62 = tail(_T_61, 1) @[Uart.scala 267:32]
      cntReg_send <= _T_62 @[Uart.scala 267:17]
      skip @[Uart.scala 266:52]
    
  module UartMain : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip rxd : UInt<1>, txd : UInt<1>, led : UInt<1>}
    
    inst Hello of Hello @[Uart.scala 283:19]
    Hello.clock <= clock
    Hello.reset <= reset
    io.led <= Hello.io.led @[Uart.scala 285:12]
    io.txd <= Hello.io.txd @[Uart.scala 286:12]
    
