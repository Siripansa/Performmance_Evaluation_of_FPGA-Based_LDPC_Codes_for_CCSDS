
#include "LastVN.h"
 #include <stdbool.h>
#include <math.h>


int main () {




  din_t Lcn[len_input] = {2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,2,2,3,2,1,2,2,2,3,2,3,2,2,2,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,3,2,3,2,2,2,3,2,3,1,2,3,2,3,3,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,1,2,1,3,4,2,4,2,3,2,2,2,2,2,2,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,2,4,2,4,2,2,3,4,2,2,1,4,2,3,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,2,3,3,4,2,2,2,2,3,2,2,3,2,3,3,3,3,2,3,2,3,3,2,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,4,3,3,3,2,3,1,2,3,4,2,3,2,4,3,3,3,2,2,3,3,3,3,2,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,1,2,2,1,3,2,4,2,2,2,3,3,2,2,2,3,3,4,2,2,2,2,2,3,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,2,3,2,4,2,2,4,3,2,2,2,3,4,1,2,2,3,3,1,3,3,3,3,2,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,1,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,1,2,3,4,2,4,2,3,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,3,3,4,2,2,4,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,3,1,2,3,4,3,2,1,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,1,3,3,4,3,2,1,4,2,2,2,2,2,2,3,2,3,3,2,2,3,2,3,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,4,2,3,4,3,2,1,2,2,4,2,3,2,2,3,4,2,3,2,3,3,1,2,3,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,2,2,1,2,2,4,2,3,2,3,2,2,2,3,3,3,2,2,2,3,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,3,2,4,3,2,4,2,2,2,2,2,4,3,2,2,2,2,4,3,2,3,3,2,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,1,4,3,2,2,1,1,1,1,4,3,3,3,2,1,4,2,3,3,3,1,1,2,3,3,2,3,3,2,3,3,3,2,4,2,2,3,2,2,2,2,3,3,1,3,1,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,3,2,1,1,2,1,1,1,3,4,2,1,1,1,3,4,3,2,3,1,3,3,2,3,2,2,2,1,2,2,3,2,4,3,3,3,3,2,4,1,2,3,3,3,4,3,3,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,1,1,3,1,3,1,1,4,2,1,3,3,1,1,1,4,2,3,3,3,1,2,2,3,3,3,4,2,2,3,3,2,4,3,3,3,2,2,2,3,2,2,3,2,3,3,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2,1,3,1,1,3,3,1,1,3,4,1,2,1,1,3,3,2,3,2,2,2,3,4,2,3,2,2,3,1,3,2,2,4,2,4,2,2,2,4,2,3,3,3,3,1,1,1,2};

  dout_t data[len_Data];
	int i ;



	// Call the function to operate on the data
	LastVN(Lcn,data);

	// Save the results to a file


	for (i=0;i<len_Data;i++) {
    fprintf(stdout,"Data =  %d\n", data[i]);
	}

}