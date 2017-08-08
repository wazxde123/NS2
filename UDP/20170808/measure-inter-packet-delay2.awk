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
	connect = $13;
	
	if ( packet_id > highest_packet_id)
		highest_packet_id=packet_id;
		
	if ( start_time[packet_id] == 0 && connect == 2)
	{
		start_time[packet_id] = time;
		printf("%f %f\n",packet_id,start_time[packet_id])
	}	
}
END {
	for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ )
	{
		if(packet_id % 2 == 1)
		{
			start = start_time[packet_id];
			end = start_time[packet_id+2];
			packet_duration = end - start; 
			if (start < end ) 
			printf("%f %f\n", start, packet_duration);
			else if (packet_id+2>highest_packet_id)
			printf("%f %f\n", start, packet_duration);
		}

	}
}