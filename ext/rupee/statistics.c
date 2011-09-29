#include "rupee.h"

#define PI 3.1415926536

double
cnd(z)
  double z;
{
  double L, K, dCND;
  static const double b  = 0.2316419;
  static const double a1 = 0.31938153;
  static const double a2 = 0.356563782;
  static const double a3 = 1.781477937;
  static const double a4 = 1.821255978;
  static const double a5 = 1.330274429;

  L = fabs(z);
  K = 1.0 / (1.0 + b * L);

  dCND = 1.0 - 1.0 / sqrt(2.0 * PI) *
      exp(-L * L / 2.0) *
      (a1 * K -
      a2 * K * K +
      a3 * K * K * K -
      a4 * K * K * K * K +
      a5 * K * K * K * K * K);

  if (z < 0.0)
    return 1.0 - dCND;
  else
    return dCND;
}

double
sum_prod(xvals, yvals, len)
  double *xvals, *yvals;
  int len;
{
  double result;
  int i;

  result = 0;

  for (i = 0; i < len; i++)
    result += xvals[i] * yvals[i];

  return result;
}

double
corr(xvals, yvals, len)
  double *xvals, *yvals;
  int len;
{
  return cov(xvals, yvals, len) / std(xvals, len) / std(yvals, len);
}

double
cov(xvals, yvals, len)
  double *xvals, *yvals;
  int len;
{
  double result, x_bar, y_bar;
  int i;

  result = 0;
  x_bar = mean(xvals, len);
  y_bar = mean(yvals, len);

  for (i = 0; i < len; i++)
    result += (xvals[i] - x_bar) * (yvals[i] - y_bar);

  return result / len;
}

double
var(values, len)
  double *values;
  int len;
{
  double x_bar, result;
  int i;
  result = 0;

  x_bar = mean(values, len);

  for (i = 0; i < len; i++)
    result += pow(values[i] - x_bar, 2);

  return result / len;
}

double
sum(values, len)
  double *values;
  int len;
{
  double result;
  int i;
  result = 0;

  for (i = 0; i < len; i++)
    result += values[i];
  
  return result;
}

double
mean(values, len)
  double *values;
  int len;
{
  return sum(values, len) / len;
}

double
std(values, len)
  double *values;
  int len;
{
  return sqrt(var(values, len));
}

/* call-seq: cnd(z)
 *
 * Returns the standard normal cumulative distribution (has a mean of zero and
 * a standard deviation of one).
 */
static VALUE
rupee_cnd(self, _z)
  VALUE self, _z;
{
  return rb_float_new(cnd(NUM2DBL(_z)));
}

/* call-seq: correlation(xvalues, yvalues)
 *
 * Returns the correlation of the supplied x- and y-values.
 */
static VALUE
rupee_corr(self, _xvals, _yvals)
  VALUE self, _xvals, _yvals;
{
  int len = RARRAY_LEN(_xvals);
  double xvals[len], yvals[len];

  rtofa(xvals, _xvals, len);
  rtofa(yvals, _yvals, len);

  return rb_float_new(corr(xvals, yvals, len));
}

/* call-seq: covariance(xvalues, yvalues)
 *
 * Returns the covariance of the supplied x- and y-values.
 */
static VALUE
rupee_cov(self, _xvals, _yvals)
  VALUE self, _xvals, _yvals;
{
  int len = RARRAY_LEN(_xvals);
  double xvals[len], yvals[len];

  rtofa(xvals, _xvals, len);
  rtofa(yvals, _yvals, len);

  return rb_float_new(cov(xvals, yvals, len));
}

/* call-seq: mean(values)
 *
 * Finds the mean of the specified values.
 */
static VALUE
rupee_mean(self, _values)
  VALUE self, _values;
{
  int len = RARRAY_LEN(_values);
  double values[len];

  rtofa(values, _values, len);

  return rb_float_new(mean(values, len));
}

/* call-seq: standard_deviation(values)
 *
 * Finds the standard deviation of the specified values.
 */
static VALUE
rupee_std(self, _values)
  VALUE self, _values;
{
  int len = RARRAY_LEN(_values);
  double values[len];

  rtofa(values, _values, len);

  return rb_float_new(std(values, len));
}

/* call-seq: sum(values)
 *
 * Finds the sum of the specified values.
 */
static VALUE
rupee_sum(self, _values)
  VALUE self, _values;
{
  int len = RARRAY_LEN(_values);
  double values[len];

  rtofa(values, _values, len);

  return rb_float_new(sum(values, len));
}

/* call-seq: variance(values)
 *
 * Finds the variance of the specified values.
 */
static VALUE
rupee_var(self, _values)
  VALUE self, _values;
{
  int len = RARRAY_LEN(_values);
  double values[len];

  rtofa(values, _values, len);

  return rb_float_new(var(values, len));
}

void
init_distribution()
{
  VALUE klass, singleton;

#if 0
  VALUE module = rb_define_module("Rupee");
#endif

  klass = rb_define_class_under(module, "Statistics", rb_cObject);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "correlation", rupee_corr, 2);
  rb_define_alias(singleton, "corr", "correlation");
  rb_define_alias(singleton, "correl", "correlation");
  rb_define_singleton_method(klass, "covariance", rupee_cov, 2);
  rb_define_alias(singleton, "cov", "covariance");
  rb_define_alias(singleton, "covar", "covariance");
  rb_define_singleton_method(klass, "cumulative_normal_distribution", rupee_cnd, 1);
  rb_define_alias(singleton, "cnd", "cumulative_normal_distribution");
  rb_define_singleton_method(klass, "mean", rupee_mean, 1);
  rb_define_alias(singleton, "average", "mean");
  rb_define_alias(singleton, "avg", "mean");
  rb_define_singleton_method(klass, "standard_deviation", rupee_std, 1);
  rb_define_alias(singleton, "std", "standard_deviation");
  rb_define_alias(singleton, "stdev", "standard_deviation");
  rb_define_singleton_method(klass, "sum", rupee_sum, 1);
  rb_define_singleton_method(klass, "variance", rupee_var, 1);
  rb_define_alias(singleton, "var", "variance");
}
