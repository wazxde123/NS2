

BEGIN {
	init = 0;
	i = 0;
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
		
	if(action == "r" && from == 2 && to == 3 && (connect == 100 || connect == 999))
	{
		pkt_byte_sum[i+1] = pkt_byte_sum[i] + pktsize;
		
		if (init == 0) 
		{
			start_time = time;
			init = 1;
		}
		end_time[i] = time;
		i=i+1;
	}
}
END {
	printf("%.2f\t%.2f\n" , end_time[0], 0);
	
	for(j=1 ; j<i ; j++)
	{
		th = pkt_byte_sum[j] / (end_time[j] - start_time)*8/1000;
		printf("%.2f\t%.2f\n", end_time[j], th);
	}
	printf("%.2f\t%.2f\n", end_time[i-1], 0);
}



