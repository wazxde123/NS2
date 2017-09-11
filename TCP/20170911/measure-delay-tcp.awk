

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
	
	if ( seq_no > highest_packet_id)
		highest_packet_id=seq_no;
		
	if ( start_time[seq_no] == 0)
	{
		start_time[seq_no] = time;
	}
		
		
	if ( connect == 100 && action != "d") 
	{
		if ( action=="r" ) 
		{
			end_time[seq_no] = time;
		}
		else
		{
			end_time[seq_no] = -1;
		}
	}
}
END {
	for ( seq_no = 0; seq_no <= highest_packet_id; seq_no++ )
	{
		start = start_time[seq_no];
		end = end_time[seq_no];
		packet_duration = end - start; 
	
	if (start < end ) 
		printf("%f %f\n", start, packet_duration);
	}
}