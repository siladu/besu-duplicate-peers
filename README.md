# invalid MAC error recreation

https://github.com/hyperledger/besu/issues/3323

Having a file containing static nodes unrelated to the running nodes cause Invalid MAC exception

This repo is a modified version of https://github.com/macfarla/besu-duplicate-peers with the addition of static-nodes

# Running

Start either besu1 or besu2 and it should get Invalid MAC errors shortly after start up

besu --config-file=besu1.conf

besu --config-file=besu2.conf

```
2022-01-28 07:55:27.701+10:00 | nioEventLoopGroup-3-8 | DEBUG | HandshakeHandlerOutbound | Wrote initial crypto handshake message to /127.0.0.1:30303.
2022-01-28 07:55:27.707+10:00 | nioEventLoopGroup-3-9 | DEBUG | AbstractHandshakeHandler | Handshake error:
org.hyperledger.besu.ethereum.p2p.rlpx.handshake.HandshakeException: Decrypting an incoming handshake message failed
	at org.hyperledger.besu.ethereum.p2p.rlpx.handshake.ecies.ECIESHandshaker.handleMessage(ECIESHandshaker.java:211)
	at org.hyperledger.besu.ethereum.p2p.rlpx.connections.netty.HandshakeHandlerInbound.nextHandshakeMessage(HandshakeHandlerInbound.java:60)
	at org.hyperledger.besu.ethereum.p2p.rlpx.connections.netty.AbstractHandshakeHandler.channelRead0(AbstractHandshakeHandler.java:92)
	at org.hyperledger.besu.ethereum.p2p.rlpx.connections.netty.AbstractHandshakeHandler.channelRead0(AbstractHandshakeHandler.java:44)
	at io.netty.channel.SimpleChannelInboundHandler.channelRead(SimpleChannelInboundHandler.java:99)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365)
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:357)
	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:379)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:365)
	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919)
	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:166)
	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:719)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:655)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:581)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:493)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:986)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base/java.lang.Thread.run(Thread.java:829)
Caused by: org.bouncycastle.crypto.InvalidCipherTextException: Invalid MAC.
	at org.hyperledger.besu.ethereum.p2p.rlpx.handshake.ecies.ECIESEncryptionEngine.decrypt(ECIESEncryptionEngine.java:277)
	at org.hyperledger.besu.ethereum.p2p.rlpx.handshake.ecies.ECIESEncryptionEngine.decrypt(ECIESEncryptionEngine.java:215)
	at org.hyperledger.besu.ethereum.p2p.rlpx.handshake.ecies.EncryptedMessage.decryptMsgEIP8(EncryptedMessage.java:94)
	at org.hyperledger.besu.ethereum.p2p.rlpx.handshake.ecies.ECIESHandshaker.handleMessage(ECIESHandshaker.java:203)
	... 20 more
```
