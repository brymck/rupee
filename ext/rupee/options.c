#include "rupee.h"

/* Whether a particular string refers to a call option (returns false for put) */
static bool is_call(const char *call_put_flag)
{
  /* Returns true for everything unless it starts with a 'p' */
  return (call_put_flag[0] != 'p');
}

static double bs(const char *call_put_flag, double S, double X, double T, double r, double q, double v)
{
  double d1, d2;

  d1 = (log(S / X) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return S * exp(-q * T) * cnd(d1) - X * exp(-r * T) * cnd(d2);
  else
    return X * exp(-r * T) * cnd(-d2) - S * exp(-q * T) * cnd(-d1);
}

/* call-seq:
 *   Rupee.black_scholes(call_put_flag, forward, strike_price, time_to_expiry, risk_free_rate, volatility)
 * 
 * The Black-Scholes European call/put valuation
 * 
 * ==== Arguments
 *
 * * +call_put_flag+ - Whether the instrument is a call (c) or a put (p)
 * * +forward+ - The current forward value
 * * +strike_price+ - The option's strike price
 * * +time_to_expiry+ - The time to maturity in years
 * * +risk_free_rate+ - The risk-free rate through expiry
 * * +dividend_yield+ - The annual dividend yield
 * * +volatility+ - The implied volatility at expiry
 */
static VALUE rupee_black_scholes(VALUE self, VALUE rcall_put_flag, VALUE rF, VALUE rX, VALUE rT, VALUE rr, VALUE rq, VALUE rv)
{
  const char *call_put_flag;
  double F, X, T, r, q, v;

  call_put_flag = StringValuePtr(rcall_put_flag);
  F = NUM2DBL(rF);
  X = NUM2DBL(rX);
  T = NUM2DBL(rT);
  r = NUM2DBL(rr);
  q = NUM2DBL(rq);
  v = NUM2DBL(rv);

  return rb_float_new(bs(call_put_flag, F, X, T, r, q, v));
}

double gbs(const char *call_put_flag, double S, double X, double T, double r, double b, double v)
{
  double d1, d2;

  d1 = (log(S / X) + (b + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return S * exp((b - r) * T) * cnd(d1) - X * exp(-r * T) * cnd(d2);
  else
    return X * exp(-r * T) * cnd(-d2) - S * exp((b - r) * T) * cnd(-d1);
}

/* call-seq:
 *   Rupee.generalized_black_scholes(call_put_flag, forward, strike_price, time_to_expiry, risk_free_rate, volatility)
 * 
 * The generalized Black-Scholes European call/put valuation
 * 
 * ==== Arguments
 *
 * * +call_put_flag+ - Whether the instrument is a call (c) or a put (p)
 * * +forward+ - The current forward value
 * * +strike_price+ - The option's strike price
 * * +time_to_expiry+ - The time to maturity in years
 * * +risk_free_rate+ - The risk-free rate through expiry
 * * +cost_of_carry+ - The annualized cost of carry
 * * +volatility+ - The implied volatility at expiry
 */
static VALUE rupee_generalized_black_scholes(VALUE self, VALUE rcall_put_flag, VALUE rF, VALUE rX, VALUE rT, VALUE rr, VALUE rb, VALUE rv)
{
  const char *call_put_flag;
  double F, X, T, r, b, v;

  call_put_flag = StringValuePtr(rcall_put_flag);
  F = NUM2DBL(rF);
  X = NUM2DBL(rX);
  T = NUM2DBL(rT);
  r = NUM2DBL(rr);
  b = NUM2DBL(rb);
  v = NUM2DBL(rv);

  return rb_float_new(gbs(call_put_flag, F, X, T, r, b, v));
}

static double black76(const char *call_put_flag, double F, double X, double T, double r, double v)
{
  double d1, d2;

  d1 = (log(F / X) + (v * v / 2.0) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return exp(-r * T) * (F * cnd(d1) - X * cnd(d2));
  else
    return exp(-r * T) * (X * cnd(-d2) - F * cnd(-d1));
}

/* call-seq:
 *   Rupee.black76(call_put_flag, forward, strike_price, time_to_expiry, risk_free_rate, volatility)
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
  const char *call_put_flag;
  double F, X, T, r, v;

  call_put_flag = StringValuePtr(rcall_put_flag);
  F = NUM2DBL(rF);
  X = NUM2DBL(rX);
  T = NUM2DBL(rT);
  r = NUM2DBL(rr);
  v = NUM2DBL(rv);

  return rb_float_new(black76(call_put_flag, F, X, T, r, v));
}

void init_options()
{
  VALUE klass, singleton;

#if 0
  VALUE module = rb_define_module("Rupee");
#endif

  klass = rb_define_class_under(module, "Options", rb_cObject);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "black_scholes", rupee_black_scholes, 7);
  rb_define_alias(singleton, "bs", "black_scholes");
  rb_define_singleton_method(klass, "generalized_black_scholes", rupee_generalized_black_scholes, 7);
  rb_define_alias(singleton, "gbs", "generalized_black_scholes");
  rb_define_singleton_method(klass, "black76", rupee_black76, 6);
}
