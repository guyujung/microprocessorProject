#include "base.h"

extern void to_grayscale(int rgb_index, int gray_index); 
extern void relocate_address(int read_index, int write_index);
extern unsigned int max_val(unsigned int num1, unsigned int num2, unsigned int num3);
extern unsigned int min_val(unsigned int num1, unsigned int num2, unsigned int num3);
extern int max_4_number(int num1, int num2, int num3, int num4);
extern void conv_and_relu_1kernel(int read_index, int write_index);
extern void max_pooling(int read_index, int write_index);
extern void TO_GRAY(int rgb_index, int gray_index);
extern void CHANGE_ADDR(int read_index, int write_index);
extern void CHANGE_ADDR2(int read_index, int write_index);

int ind_4 = 0x40000000;
int ind_5 = 0x50000000;
int ind_6 = 0x60000000;
int ind_7 = 0x70000000;
int ind_8 = 0x80000000;

int main (void)
{
	//to_grayscale(ind_4,ind_5);
	//relocate_address(ind_5,ind_6);
	//CHANGE_ADDR2(ind_5,ind_6);
	//TO_GRAY(ind_4,ind_5);
	//conv_and_relu_1kernel(ind_6, ind_7);
	//max_pooling(ind_7, ind_8);
	//int x = max_val(4,9,6);
	
  _sys_exit(0);
}
