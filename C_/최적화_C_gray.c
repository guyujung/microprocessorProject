void to_grayscale(int rgb_index, int gray_index)
{
	int rgb = rgb_index;
	int gray = gray_index;
	unsigned char* rgb_start = (unsigned char*)rgb;
	unsigned char* gray_start = (unsigned char*)gray;
	int j = 0;
	for (int i=0;i<0x5EEBFF;i+=3)
	{
		int sum_avg = (max_val(*(rgb_start+i),*(rgb_start+i+1),*(rgb_start+i+2))+ min_val(*(rgb_start+i),*(rgb_start+i+1),*(rgb_start+i+2)))/2;
		*(gray_start+j) = (unsigned char)sum_avg;
		j++;
	}
}