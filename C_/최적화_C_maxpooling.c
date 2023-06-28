void max_pooling(int read_index, int write_index)
{
	int read = read_index;
	int write = write_index;
	unsigned char* read_start = (unsigned char*)read;
	unsigned char* write_start = (unsigned char*)write;
	int k = 0;
	for (int i=0;i<1080;i+=2)
	{
		for (int j=0;j<0x780;j+=2)
		{
			int first_num = (i*0x2000)+j;
			int max_res = max_4_number(
				(*(read_start + first_num)),
				(*(read_start + first_num + 1)),
				(*(read_start + first_num + 0x2000)),
				(*(read_start + first_num + 0x2001))
			);
			*(write_start + k) = (unsigned int)max_res;
			k++;
		}
	}
}