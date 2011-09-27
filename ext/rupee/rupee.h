#ifndef RUPEE
#define RUPEE

#include <ruby.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>

extern VALUE module;

/* Statistics */
double cnd(double);
void init_distribution();

/* Options */
double gbs(const char *call_put_flag, double S, double X, double T, double r,
    double b, double v);
void init_option();

#endif
