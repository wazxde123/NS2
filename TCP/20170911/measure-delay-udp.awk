

BEGIN {
	highest_packet_id = 0;

}
{
	action = $1;
	time = $2;
	from = $3;
	to = $4;
	type = $5;
	pktsize = $6;
	flow_id = $8;
	src = $9;
	dst = $10;
	seq_no = $11;
	packet_id = $12;
	udp_seqno = $13;
	connect = $14;
	
	if ( udp_seqno > highest_packet_id)
		highest_packet_id=udp_seqno;
		
	if ( start_time[udp_seqno] == 0)
	{
		start_time[udp_seqno] = time;
	}
		
		
	if ( connect == 500 && action != "d") 
	{
		if ( action=="r" ) 
		{
			end_time[udp_seqno] = time;
		}
		else
		{
			end_time[udp_seqno] = -1;
		}
	}
}
END {
	for ( udp_seqno = 0; udp_seqno <= highest_packet_id; udp_seqno++ )
	{
		start = start_time[udp_seqno];
		end = end_time[udp_seqno];
		packet_duration = end - start; 
	
	if (start < end ) 
		printf("%f %f\n", start, packet_duration);
	}
}