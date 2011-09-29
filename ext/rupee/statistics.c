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
mean(values, len)
  double *values;
  int len;
{
  double result;
  int i;
  result = 0;
  
  for (i = 0; i < len; i++)
    result += values[i];

  return result / len;
}

double
std(values, len)
  double *values;
  int len;
{
  double bar_x, result;
  int i;
  result = 0;

  bar_x = mean(values, len);

  for (i = 0; i < len; i++)
    result += pow(values[i] - bar_x, 2);

  return sqrt(result / (len - 1));
}

/* call-seq: cnd(z)
 *
 * Returns the standard normal cumulative distribution (has a mean of zero and
 * a standard deviation of one).
 *
 * ==== Arguments
 *
 * * +z+ - The value for which you want the distribution
 */
static VALUE
rupee_cnd(self, _z)
  VALUE self, _z;
{
  return rb_float_new(cnd(NUM2DBL(_z)));
}

static VALUE
rupee_std(self, _values)
  VALUE self, _values;
{
  int len = RARRAY_LEN(_values);
  double *values;

  rtofa(values, _values, len);

  return rb_float_new(std(values, len));
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

  rb_define_singleton_method(klass, "cumulative_normal_distribution", rupee_cnd, 1);
  rb_define_alias(singleton, "cnd", "cumulative_normal_distribution");
  rb_define_singleton_method(klass, "standard_deviation", rupee_std, 1);
  rb_define_alias(singleton, "std", "standard_deviation");
  rb_define_alias(singleton, "stdev", "standard_deviation");
}
