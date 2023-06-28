#include "base.h"
unsigned int max_val(unsigned int num1, unsigned int num2, unsigned int num3) 
{
    int max = num1;
    if (num2 > max) max = num2;
    if (num3 > max) max = num3;
    return max;
}

unsigned int min_val(unsigned int num1, unsigned int num2, unsigned int num3)
{
    int min = num1;
    if (num2 < min) min = num2;
    if (num3 < min) min = num3;
    return min;
}

int max_4_number(int num1, int num2, int num3, int num4) 
{
    int max = num1;
    if (num2 > max) max = num2;
    if (num3 > max) max = num3;
    if (num4 > max) max = num4;
    return max;
}

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




