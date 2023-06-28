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