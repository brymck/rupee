#ifndef RUPEE
#define RUPEE

#include <ruby.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>

extern VALUE module;
extern VALUE superklass;

/* Utilities */
double *rtofa(double *dest, VALUE src, int len);
double avg(double x, double y);
double simple_df(double r, double time, bool discrete);

/* Statistics */
double cnd(double);
double std(double *, int);
void init_distribution();

/* Options */
double gbs(const char *call_put_flag, double S, double X, double T, double r,
    double b, double v);
void init_option();

/* Bonds */
double bond_dur(double *times, double *cflows, double r, int len, bool discrete);
double bond_price(double *times, double *cflows, double r, int len, bool discrete);
double bond_ytm(double *times, double *cflows, double r, int len, bool discrete);
void init_bond();

/* Futures */
double future_price(double S, double r, double ttm);
void init_future();

#endif
