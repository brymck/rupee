#include "rupee.h"

double
future_price(S, r, ttm)
  double S, r, ttm;
{
  return S * exp(r * ttm);
}

/* call-seq: price(underlying, rate, time_to_maturity)
 *
 * The future's price based on the provided underlying, risk-free rate and time
 * to maturity
 */
static VALUE
price(self, _S, _r, _ttm)
  VALUE self, _S, _r, _ttm;
{
  double S, r, ttm;

  S   = NUM2DBL(_S);
  r   = NUM2DBL(_r);
  ttm = NUM2DBL(_ttm);

  return rb_float_new(future_price(S, r, ttm));
}

void
init_future()
{
  VALUE klass, singleton;

#if 0
  VALUE module = rb_define_module("Rupee");
  VALUE superklass = rb_define_class_under(module, "Security", rb_cObject);
#endif

  klass = rb_define_class_under(module, "Future", superklass);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "price", price, 3);
  rb_define_alias(singleton, "value", "price");
}
