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
double bnd(double, double, double);
double cnd(double);
double cndev(double);
double corr(double *, double *, int);
double cov(double *, double *, int);
double mean(double *, int);
double nd(double);
double pdf(double);
double std(double *, int);
double sum(double *, int);
double sum_prod(double *, double *, int);
double var(double *, int);
void init_distribution();

/* Options */
double bs(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
double bs_gamma(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
double delta(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
double gbs(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
double rho(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
double theta(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
double vega(const char *call_put_flag, double S, double K, double T, double r,
    double q, double v);
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
