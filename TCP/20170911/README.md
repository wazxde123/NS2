# NS2

#傳送端使用Agent/TCP,接收端使用Agent/TCPSink/mTcpSink  
#功能：藉由新增2個欄位來作判別，一個是udp_seqno代表udp目前傳出去的封包，另一個是connect_代表是tcp封包還是udp封包  
#trace數據：分成兩個部分有無(queuq)，主要監測TCP(original)分成2條和一條分別丟TCP封包和UDP封包   
