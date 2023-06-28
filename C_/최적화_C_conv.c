void conv_and_relu_1kernel(int read_index, int write_index)
{
	float kernel_value[9] = {0.125,-0.14,0.05,-0.14,0,-0.075,0.05,-0.075,0.125};
	int read = read_index;
	int write = write_index;
	unsigned char* read_start = (unsigned char*)read;
	unsigned char* write_start = (unsigned char*)write;
	for (int i=0;i<1080;i++)
	{
		for (int j=0;j<0x780;j++)
		{
			int center_num = (i*0x2000)+j;
			float conv_res = (
			(*(read_start + center_num - 0x2001))*kernel_value[0]+
			(*(read_start + center_num - 0x2000))*kernel_value[1]+	
			(*(read_start + center_num - 0x1FFF))*kernel_value[2]+
			(*(read_start + center_num - 0x1))*kernel_value[3]+
			(*(read_start + center_num - 0x0))*kernel_value[4]+
			(*(read_start + center_num + 0x1))*kernel_value[5]+
			(*(read_start + center_num + 0x1FFF))*kernel_value[6]+
			(*(read_start + center_num + 0x2000))*kernel_value[7]+
			(*(read_start + center_num + 0x2001))*kernel_value[8]);
			if (conv_res<0)
				conv_res = 0;
			else
				conv_res = 255;
			int conv_res_int = (int)(conv_res+0.5f);
			*(write_start + center_num) = conv_res_int;
		}
	}
}