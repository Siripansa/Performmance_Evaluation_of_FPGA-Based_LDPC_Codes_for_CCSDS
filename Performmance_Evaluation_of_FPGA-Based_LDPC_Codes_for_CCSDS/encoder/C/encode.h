#ifndef ARRAY_IO_H_
#define ARRAY_IO_H_
 
#include <stdio.h>
#include <stdbool.h>

typedef bool in;

#define N 1024
#define M 2048
#define sub_m 128
#define I_max 76
//#define inx 529152



//void array_io (in u[4], in cw[8]);
void encode (in u[N], in cw[M]);


#endif
