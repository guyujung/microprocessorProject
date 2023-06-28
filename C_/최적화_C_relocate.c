void relocate_address(int read_index, int write_index)
{
	int read = read_index;
	int write = write_index;
	unsigned char* read_start = (unsigned char*)read;
	unsigned char* write_start = (unsigned char*)write;
	int count = 0;
	int j = 0;
	for (int i=0;i<0x1FA400;i++)
	{
		unsigned int x = *(read_start+i);
		if(count == 0x780)
		{
			count = 0;
			j+=0x1880;
		}
		*(write_start+j) = x; 
		count++;
		j++;
	}
}