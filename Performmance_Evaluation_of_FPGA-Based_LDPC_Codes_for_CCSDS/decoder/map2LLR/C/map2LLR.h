
#ifndef decode_H_
#define decode_H_
 
#include <stdio.h>
#include <stdbool.h>


typedef int din_t;
typedef int dout_t;


#define len_input  2048
#define len_Data  7680


void map2LLR(din_t Lch_Q [len_input],dout_t  Lvn [len_Data]);

#endif
