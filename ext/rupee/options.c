#include "rupee.h"

/*
 * Whether a particular string refers to a call option (returns false for put)
 *
 * ==== Arguments
 *
 * * +call_put_flag+ - The string to check
 */
static bool is_call(const char * call_put_flag)
{
  /* Returns to for everything unless it starts with a 'p' */
  return (call_put_flag[0] != 'p');
}

static double _black76(const char *call_put_flag, double F, double X, double T, double r, double v)
{
  double d1, d2;

  d1 = (log(F / X) + (v * v / 2.0) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return exp(-r * T) * (F * _cnd(d1) - X * _cnd(d2));
  else
    return exp(-r * T) * (X * _cnd(-d2) - F * _cnd(-d1));
}

/* call-seq: Rupee.black76(call_put_flag, forward, strike_price, time_to_expiry, risk_free_rate, volatility)
 *
 * The Black-76 valuation for options on futures and forwards
 * 
 * ==== Arguments
 *
 * * +call_put_flag+ - Whether the instrument is a call (c) or a put (p)
 * * +forward+ - The current forward value
 * * +strike_price+ - The option's strike price
 * * +time_to_expiry+ - The time to maturity in years
 * * +risk_free_rate+ - The risk-free rate through expiry
 * * +volatility+ - The implied volatility at expiry
 */
static VALUE rupee_black76(VALUE self, VALUE rcall_put_flag, VALUE rF, VALUE rX, VALUE rT, VALUE rr, VALUE rv)
{
  const char * call_put_flag = StringValuePtr(rcall_put_flag);
  double F, X, T, r, v;

  F = NUM2DBL(rF);
  X = NUM2DBL(rX);
  T = NUM2DBL(rT);
  r = NUM2DBL(rr);
  v = NUM2DBL(rv);

  return rb_float_new(_black76(call_put_flag, F, X, T, r, v));
}

void init_options()
{
  /* Fool RDoc into thinking you're defining a class */  
#if 0
  VALUE cRupee = rb_define_class("Rupee", rb_cObject);
#endif

  rb_define_singleton_method(cRupee, "black76", rupee_black76, 6);
}
