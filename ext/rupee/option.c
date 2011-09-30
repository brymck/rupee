#include "rupee.h"

/* Whether a particular string refers to a call option (false for put) */
static bool
is_call(call_put_flag)
  const char *call_put_flag;
{
  /* Returns true for everything unless it starts with a 'p' */
  return (call_put_flag[0] != 'p');
}

double
bs(call_put_flag, S, X, T, r, q, v)
  const char *call_put_flag;
  double S, X, T, r, q, v;
{
  double d1, d2;

  d1 = (log(S / X) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return S * exp(-q * T) * cnd(d1) - X * exp(-r * T) * cnd(d2);
  else
    return X * exp(-r * T) * cnd(-d2) - S * exp(-q * T) * cnd(-d1);
}

// GREEKS

double
delta(call_put_flag, S, K, T, r, q, v)
  const char *call_put_flag;
  double S, K, T, r, q, v;
{
  double d1;
  
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));

  if (is_call(call_put_flag))
    return exp(-q * T) * cnd(d1);
  else
    return -exp(-q * T) * cnd(-d1);
}

double
vega(call_put_flag, S, K, T, r, q, v)
  const char *call_put_flag;
  double S, K, T, r, q, v;
{
  double d1;

  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));

  return S * exp(-q * T) * pdf(d1) * sqrt(T);
}

double
theta(call_put_flag, S, K, T, r, q, v)
  const char *call_put_flag;
  double S, K, T, r, q, v;
{
  double d1, d2;
  
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return -exp(-q * T) * (S * pdf(d1) * v) / (2 * sqrt(T)) -
      r * K * exp(-r * T) * cnd(d2) + q * S * exp(-q * T) * cnd(d1);
  else
    return -exp(-q * T) * (S * pdf(d1) * v) / (2 * sqrt(T)) +
      r * K * exp(-r * T) * cnd(-d2) - q * S * exp(-q * T) * cnd(-d1);
}

double
rho(call_put_flag, S, K, T, r, q, v)
  const char *call_put_flag;
  double S, K, T, r, q, v;
{
  double d1, d2;
  
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return K * T * exp(-r * T) * cnd(d2);
  else
    return -K * T * exp(-r * T) * cnd(-d2);
}

double
bs_gamma(call_put_flag, S, K, T, r, q, v)
  const char *call_put_flag;
  double S, K, T, r, q, v;
{
  double d1;
  
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));

  return exp(-q * T) * pdf(d1) / (S * v * sqrt(T));
}

/* call-seq: delta(call_put_flag, underlying, strike, time, rate, div_yield,
 * volatility)
 *
 * Returns the delta options Greek (sensitivity to changes in the underlying's
 * price
 */
static VALUE
rupee_delta(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  return rb_float_new(delta(call_put_flag, S, K, T, r, q, v));
}

/* call-seq: vega(call_put_flag, underlying, strike, time, rate, div_yield,
 * volatility)
 *
 * Returns the vega options Greek (sensitivity to changes in volatility)
 */
static VALUE
rupee_vega(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  return rb_float_new(vega(call_put_flag, S, K, T, r, q, v));
}

/* call-seq: theta(call_put_flag, underlying, strike, time, rate, div_yield,
 * volatility)
 *
 * returns the theta options greek (sensitivity to the passage of time; time
 * decay)
 */
static VALUE
rupee_theta(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  return rb_float_new(theta(call_put_flag, S, K, T, r, q, v));
}

/* call-seq: rho(call_put_flag, underlying, strike, time, rate, div_yield,
 * volatility)
 *
 * Returns the rho options Greek (sensitivity to the risk-free rate)
 */
static VALUE
rupee_rho(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  return rb_float_new(rho(call_put_flag, S, K, T, r, q, v));
}

/* call-seq: gamma(call_put_flag, underlying, strike, time, rate, div_yield,
 * volatility)
 *
 * Returns the gamma options Greek (sensitivity to changes in delta; convexity)
 */
static VALUE
rupee_gamma(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  return rb_float_new(bs_gamma(call_put_flag, S, K, T, r, q, v));
}

/* call-seq: vanna(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the vanna options Greek (sensitivity of delta to changes in
 * volatility)
 */
static VALUE
rupee_vanna(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;
  
  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  return rb_float_new(-exp(-q * T) * pdf(d1) * d2 / v);
}

/* call-seq: charm(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the charm options Greek (sensitivity of delta to the passage of
 * time)
 */
static VALUE
rupee_charm(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return rb_float_new(-q * exp(-q * T) * cnd(d1) + exp(-q * T) * pdf(d1) *
      (2 * (r - q) * T - d2 * v * sqrt(T)) / (2 * T * v * sqrt(T)));
  else
    return rb_float_new(q * exp(-q * T) * cnd(-d1) + exp(-q * T) * pdf(d1) *
      (2 * (r - q) * T - d2 * v * sqrt(T)) / (2 * T * v * sqrt(T)));
}

/* call-seq: rupee_speed(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the speed options Greek (sensitivity of gamma to changes in the
 * underlying's price).
 */
static VALUE
rupee_speed(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));

  return rb_float_new(-exp(-q * T) * pdf(d1) / (S * S * v * sqrt(T)) *
      (d1 / (v * sqrt(T)) + 1));
}

/* call-seq: zomma(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the zomma options Greek (sensitivity of gamma to changes in
 * volatility)
 */
static VALUE
rupee_zomma(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;
  
  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  return rb_float_new(-exp(-q * T) * pdf(d1) * (d1 * d2 - 1) /
      (S * v * v * sqrt(T)));
}

/* call-seq: color(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the color options Greek (sensitivity of gamma to the passage of
 * time)
 */
static VALUE
rupee_color(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  return rb_float_new(-exp(-q * T) * pdf(d1) / (2.0 * S * T * v * sqrt(T)) *
      (2.0 * q * T + 1.0 + (2.0 * (r - q) * T - d2 * v * sqrt(T)) /
      (2.0 * T * v * sqrt(T)) * d1));
}

/* call-seq: dvega_dtime(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the dvega dtime options Greek (sensitivity of vega to the passage of
 * time)
 */
static VALUE
rupee_dvega_dtime(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  return rb_float_new(S * exp(-q * T) * pdf(d1) * sqrt(T) *
      (q + ((r - q) * d1) / (v * sqrt(T)) - (1 + d1 * d2) / (2 * T)));
}

/* call-seq: vomma(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the vomma options Greek (sensitivity of vega to changes in
 * volatility)
 */
static VALUE
rupee_vomma(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  return rb_float_new(S * exp(-q * T) * pdf(d1) * sqrt(T) * d1 * d2 / v);
}

/* call-seq: dual_delta(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the dual delta options Greek (probability of finishing in-the-money)
 */
static VALUE
rupee_dual_delta(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return rb_float_new(-exp(-q * T) * cnd(d2));
  else
    return rb_float_new(exp(-q * T) * cnd(-d2));
}

/* call-seq: dual_gamma(call_put_flag, S, K, T, r, q, v)
 *
 * Returns the dual gamma options Greek.
 */
static VALUE
rupee_dual_gamma(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double d1, d2, S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);
  d1 = (log(S / K) + (r - q + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  return rb_float_new(exp(-r * T) * pdf(d2) / (K * v * sqrt(T)));
}


/* call-seq: implied_volatility(call_put_flag, underlying, strike, time, rate,
 * div_yield, price)
 * 
 * Returns the Black-Scholes implied volatility using the Newton-Raphson method
 */
static VALUE
rupee_impl_vol(self, _call_put_flag, _S, _K, _T, _r, _q, _cm)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _cm;
{
  static const double epsilon = 0.00000001;
  double vi, ci, vegai, min_diff, S, K, T, r, q, cm;
  const char *call_put_flag;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  cm = NUM2DBL(_cm);

  // Manaster and Koehler seed value
  vi = sqrt(abs(log(S / K) + r * T) * 2 / T);
  ci = bs(call_put_flag, S, K, T, r, q, vi);
  vegai = vega(call_put_flag, S, K, T, r, q, vi);
  min_diff = abs(cm - ci);

  while (min_diff >= epsilon) {
    vi -= (ci - cm) / vegai;
    ci = bs(call_put_flag, S, K, T, r, q, vi);
    vegai = vega(call_put_flag, S, K, T, r, q, vi);
    min_diff = abs(cm - ci);
  }

  if (min_diff < epsilon)
    return vi;
  else
    return 0;
}

/* call-seq: black_scholes(call_put_flag, underlying, strike, time, rate,
 * volatility)
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
static VALUE
rupee_black_scholes(self, _call_put_flag, _S, _K, _T, _r, _q, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _q, _v;
{
  const char *call_put_flag;
  double S, K, T, r, q, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  q = NUM2DBL(_q);
  v = NUM2DBL(_v);

  return rb_float_new(bs(call_put_flag, S, K, T, r, q, v));
}

double
gbs(call_put_flag, S, K, T, r, b, v)
  const char *call_put_flag;
  double S, K, T, r, b, v;
{
  double d1, d2;

  d1 = (log(S / K) + (b + v * v / 2) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return S * exp((b - r) * T) * cnd(d1) - K * exp(-r * T) * cnd(d2);
  else
    return K * exp(-r * T) * cnd(-d2) - S * exp((b - r) * T) * cnd(-d1);
}

/* call-seq:
 *   generalized_black_scholes(call_put_flag, forward, strike_price,
 *   time_to_expiry, risk_free_rate, volatility)
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
static VALUE
rupee_generalized_black_scholes(self, _call_put_flag, _S, _K, _T, _r, _b, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _b, _v;
{
  const char *call_put_flag;
  double S, K, T, r, b, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  b = NUM2DBL(_b);
  v = NUM2DBL(_v);

  return rb_float_new(gbs(call_put_flag, S, K, T, r, b, v));
}

static double
black76(call_put_flag, S, K, T, r, v)
  const char *call_put_flag;
  double S, K, T, r, v;
{
  double d1, d2;

  d1 = (log(S / K) + (v * v / 2.0) * T) / (v * sqrt(T));
  d2 = d1 - v * sqrt(T);

  if (is_call(call_put_flag))
    return exp(-r * T) * (S * cnd(d1) - K * cnd(d2));
  else
    return exp(-r * T) * (K * cnd(-d2) - S * cnd(-d1));
}

/* call-seq:
 *   black76(call_put_flag, forward, strike_price, time_to_expiry,
 *   risk_free_rate, volatility)
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
static VALUE
rupee_black76(self, _call_put_flag, _S, _K, _T, _r, _v)
  VALUE self, _call_put_flag, _S, _K, _T, _r, _v;
{
  const char *call_put_flag;
  double S, K, T, r, v;

  call_put_flag = StringValuePtr(_call_put_flag);
  S = NUM2DBL(_S);
  K = NUM2DBL(_K);
  T = NUM2DBL(_T);
  r = NUM2DBL(_r);
  v = NUM2DBL(_v);

  return rb_float_new(black76(call_put_flag, S, K, T, r, v));
}

void
init_option()
{
  VALUE klass, singleton;

#if 0
  VALUE module = rb_define_module("Rupee");
  VALUE superklass = rb_define_class_under(module, "Security", rb_cObject);
#endif

  klass = rb_define_class_under(module, "Option", superklass);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "black76", rupee_black76, 6);
  rb_define_singleton_method(klass, "black_scholes", rupee_black_scholes, 7);
  rb_define_alias(singleton, "bs", "black_scholes");
  rb_define_singleton_method(klass, "charm", rupee_charm, 7);
  rb_define_singleton_method(klass, "color", rupee_color, 7);
  rb_define_singleton_method(klass, "delta", rupee_delta, 7);
  rb_define_singleton_method(klass, "dual_delta", rupee_dual_delta, 7);
  rb_define_singleton_method(klass, "dual_gamma", rupee_dual_gamma, 7);
  rb_define_singleton_method(klass, "dvega_dtime", rupee_dvega_dtime, 7);
  rb_define_singleton_method(klass, "gamma", rupee_gamma, 7);
  rb_define_singleton_method(klass, "generalized_black_scholes",
      rupee_generalized_black_scholes, 7);
  rb_define_alias(singleton, "gbs", "generalized_black_scholes");
  rb_define_singleton_method(klass, "implied_volatility", rupee_impl_vol, 7);
  rb_define_singleton_method(klass, "rho", rupee_rho, 7);
  rb_define_singleton_method(klass, "speed", rupee_speed, 7);
  rb_define_singleton_method(klass, "theta", rupee_theta, 7);
  rb_define_singleton_method(klass, "vanna", rupee_vanna, 7);
  rb_define_singleton_method(klass, "vega", rupee_vega, 7);
  rb_define_singleton_method(klass, "vomma", rupee_vomma, 7);
  rb_define_singleton_method(klass, "zomma", rupee_zomma, 7);
}













