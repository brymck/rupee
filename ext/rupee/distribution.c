#include "rupee.h"

#define PI 3.1415926536

double cnd(double z)
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

/* call-seq: cnd(z)
 *
 * Returns the standard normal cumulative distribution (has a mean of zero and
 * a standard deviation of one).
 *
 * ==== Arguments
 *
 * * +z+ - The value for which you want the distribution
 */
static VALUE rupee_cnd(VALUE self, VALUE rz)
{
  return rb_float_new(cnd(NUM2DBL(rz)));
}

/* Maybe this does something */
void init_distribution()
{
  VALUE klass, singleton;

#if 0
  VALUE module = rb_define_module("Rupee");
#endif

  klass = rb_define_class_under(module, "Distribution", rb_cObject);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "cnd", rupee_cnd, 1);
}
