#ifndef RUPEE_OPTIONS
#define RUPEE_OPTIONS

#include "rupee.h"

double gbs(const char *call_put_flag, double S, double X, double T, double r,
    double b, double v);
void init_options();

#endif
