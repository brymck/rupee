#include "rupee.h"

#define ACCURACY 0.00001
#define MAX_ITERATIONS 200

double
bond_conv(times, cflows, r, len, discrete)
  double *times, *cflows, r;
  int len;
  bool discrete;
{
  double C, B;
  int i;
  C = 0;

  for (i = 0; i < len; i++) {
    double time, time_sq;
    time = times[i];

    // I'm a little skeptical this is correct
    if (discrete)
      time_sq = time * (times[i] + 1);
    else
      time_sq = pow(time, 2);

    C += cflows[i] * time_sq * simple_df(r, time, discrete);
  }

  B = bond_price(times, cflows, r, len, discrete);

  // Same goes for this; I don't know why you'd discount only under discrete
  // compounding. That doesn't seem like a market convention.
  if (discrete)
    return C / pow(1 + r, 2) / B;
  else
    return C / B;
};

double
bond_dur(times, cflows, r, len, discrete)
  double *times, *cflows, r;
  int len;
  bool discrete;
{
  double S, D1;
  int i;
  S = 0;
  D1 = 0;

  for (i = 0; i < len; i++) {
    double time, dcflow;

    time = times[i];
    dcflow = cflows[i] * simple_df(r, time, discrete);

  	S  += dcflow;
 	  D1 += dcflow * time;
  }

  return D1 / S;
}

double
bond_price(times, cflows, r, len, discrete)
  double *times, *cflows, r;
  int len;
  bool discrete;
{
  double p, *cft;
  int i;
  p = 0;

  for (i = 0; i < len; i++)
  	p += cflows[i] * simple_df(r, times[i], discrete);

  return p;
};

double
bond_ytm(times, cflows, price, len, discrete)
  double *times, *cflows, price;
  int len;
  bool discrete;
{
  double bot, top, r;
  int i;
  bot = 0;
  top = 1;

  while (bond_price(times, cflows, top, len, discrete) > price)
    top *= 2;

  r = avg(top, bot);

  for (i = 0; i < MAX_ITERATIONS; i++) {
    double diff;
    diff = bond_price(times, cflows, r, len, discrete) - price;

    if (fabs(diff) < ACCURACY)
      return r;
    
    if (diff > 0.0)
      bot = r;
    else
      top = r;

    r = avg(top, bot);
  };

  return r;
};

/*
 * Ruby singleton functions
 *
 * See helper functions below for description broken out by discrete and
 * continuous compounding. +discrete+ is a boolean equal to +true+ for discrete
 * compounding and +false+ for continuous compounding
 */

static VALUE
convexity(self, _times, _cflows, _r, discrete)
  VALUE self, _times, _cflows, _r;
  bool discrete;
{
  int len = RARRAY_LEN(_cflows);
  double times[len], cflows[len], r;

  rtofa(times, _times, len);
  rtofa(cflows, _cflows, len);
  r = NUM2DBL(_r);

  return rb_float_new(bond_conv(times, cflows, r, len, discrete));
};

static VALUE
duration(self, _times, _cflows, _r, discrete)
  VALUE self, _times, _cflows, _r;
  bool discrete;
{
  int len = RARRAY_LEN(_cflows);
  double times[len], cflows[len], r;
  
  rtofa(times, _times, len);
  rtofa(cflows, _cflows, len);
  r = NUM2DBL(_r);

  return rb_float_new(bond_dur(times, cflows, r, len, discrete));
}

static VALUE
macaulay(self, _times, _cflows, _price, discrete)
  VALUE self, _times, _cflows, _price;
  bool discrete;
{
  int len = RARRAY_LEN(_cflows);
  double times[len], cflows[len], price, ytm;

  rtofa(times, _times, len);
  rtofa(cflows, _cflows, len);
  price = NUM2DBL(price);

  ytm = bond_ytm(times, cflows, price, len, discrete);

  return rb_float_new(bond_dur(times, cflows, ytm, len, discrete));
};

static VALUE
price(self, _times, _cflows, _r, discrete)
  VALUE self, _times, _cflows, _r;
  bool discrete;
{
  int len = RARRAY_LEN(_cflows);
  double times[len], cflows[len], r;
  
  rtofa(times, _times, len);
  rtofa(cflows, _cflows, len);
  r = NUM2DBL(_r);

  return rb_float_new(bond_price(times, cflows, r, len, discrete));
}

static VALUE
yield_to_maturity(self, _times, _cflows, _price, discrete)
  VALUE self, _times, _cflows, _price;
  bool discrete;
{
  int len = RARRAY_LEN(_cflows);
  double times[len], cflows[len], price;

  rtofa(times, _times, len);
  rtofa(cflows, _cflows, len);
  price = NUM2DBL(_price);

  return rb_float_new(bond_ytm(times, cflows, price, len, discrete));
};

// Helper functions

/* call-seq: convexity_continuous(times, cflows, rates)
 *
 * The bond's convexity based on the provided set of times (in years), cash
 * flows and discount rates, assuming continuous compounding
 */
static VALUE
convexity_continuous(self, _times, _cflows, _r)
  VALUE self, _times, _cflows, _r;
{
  return convexity(self, _times, _cflows, _r, false);
}

/* call-seq: convexity_discrete(times, cflows, rates)
 *
 * The bond's convexity based on the provided set of times (in years), cash
 * flows and discount rates, assuming discrete compounding
 */
static VALUE
convexity_discrete(self, _times, _cflows, _r)
  VALUE self, _times, _cflows, _r;
{
  return convexity(self, _times, _cflows, _r, true);
}

/* call-seq: duration_continuous(times, cflows, rates)
 *
 * The bond's duration based on the provided set of times (in years), cash
 * flows and discount rates, assuming continuous compounding
 */
static VALUE
duration_continuous(self, _times, _cflows, _r)
  VALUE self, _times, _cflows, _r;
{
  return duration(self, _times, _cflows, _r, false);
}

/* call-seq: duration_discrete(times, cflows, rates)
 *
 * The bond's duration based on the provided set of times (in years), cash
 * flows and discount rates, assuming discrete compounding
 */
static VALUE
duration_discrete(self, _times, _cflows, _r)
  VALUE self, _times, _cflows, _r;
{
  return duration(self, _times, _cflows, _r, true);
}

/* call-seq: macaulay_continuous(times, cflows, price)
 *
 * The bond's Macaulay duration based on the provided set of times (in years),
 * cash flows and price, assuming continuous compounding
 */
static VALUE
macaulay_continuous(self, _times, _cflows, _price)
  VALUE self, _times, _cflows, _price;
{
  return macaulay(self, _times, _cflows, _price, false);
}

/* call-seq: macaulay_discrete(times, cflows, price)
 *
 * The bond's Macaulay duration based on the provided set of times (in years),
 * cash flows and price, assuming discrete compounding
 */
static VALUE
macaulay_discrete(self, _times, _cflows, _price)
  VALUE self, _times, _cflows, _price;
{
  return macaulay(self, _times, _cflows, _price, true);
}

/* call-seq: modified_discrete(times, cflows, price)
 *
 * The bond's duration based on the provided set of times (in years), cash
 * flows and price, assuming discrete compounding
 */
static VALUE
modified_discrete(self, _times, _cflows, _price)
  VALUE self, _times, _cflows, _price;
{
  int len = RARRAY_LEN(_cflows);
  double y, D, times[len], cflows[len], price;

  rtofa(times, _times, len);
  rtofa(cflows, _cflows, len);
  price = NUM2DBL(_price);

  y = bond_ytm(times, cflows, price, len, true);
  D = bond_dur(times, cflows, y, len, true);

  return rb_float_new(D / (1 + y));
};

/* call-seq: price_continuous(times, cflows, rates)
 *
 * The bond's price based on the provided set of times (in years), cash flows
 * and discount rates, assuming continuous compounding
 */
static VALUE
price_continuous(self, _times, _cflows, _r)
  VALUE self, _times, _cflows, _r;
{
  return price(self, _times, _cflows, _r, false);
}

/* call-seq: price_discrete(times, cflows, rates)
 *
 * The bond's price based on the provided set of times (in years), cash flows
 * and discount rates, assuming discrete compounding
 */
static VALUE
price_discrete(self, _times, _cflows, _r)
  VALUE self, _times, _cflows, _r;
{
  return price(self, _times, _cflows, _r, true);
}


/* call-seq: yield_to_maturity_continuous(times, cflows, rates)
 *
 * The bond's yield to maturity based on the provided set of times (in years),
 * cash flows and price, assuming continuous compounding
 */
static VALUE
yield_to_maturity_continuous(self, _times, _cflows, _price)
  VALUE self, _times, _cflows, _price;
{
  return yield_to_maturity(self, _times, _cflows, _price, false);
}

/* call-seq: yield_to_maturity_discrete(times, cflows, rates)
 *
 * The bond's yield to maturity based on the provided set of times (in years),
 * cash flows and price, assuming discrete compounding
 */
static VALUE
yield_to_maturity_discrete(self, _times, _cflows, _price)
  VALUE self, _times, _cflows, _price;
{
  return yield_to_maturity(self, _times, _cflows, _price, true);
}

void
init_bond()
{
  VALUE klass, singleton;

#if 0
  VALUE module = rb_define_module("Rupee");
  VALUE superklass = rb_define_class_under(module, "Security", rb_cObject);
#endif

  klass = rb_define_class_under(module, "Bond", superklass);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "convexity", convexity_discrete, 3);
  rb_define_singleton_method(klass, "continuous_convexity", convexity_continuous, 3);
  rb_define_singleton_method(klass, "continuous_duration", duration_continuous, 3);
  rb_define_singleton_method(klass, "continuous_macaulay", macaulay_continuous, 3);
  rb_define_singleton_method(klass, "continuous_price", price_continuous, 3);
  rb_define_singleton_method(klass, "continuous_yield_to_maturity", yield_to_maturity_continuous, 3);
  rb_define_alias(singleton, "continuous_yield", "continuous_yield_to_maturity");
  rb_define_alias(singleton, "continuous_ytm", "continuous_yield_to_maturity");
  rb_define_singleton_method(klass, "duration", duration_discrete, 3);
  rb_define_alias(singleton, "dur", "duration");
  rb_define_singleton_method(klass, "macaulay", macaulay_discrete, 3);
  rb_define_alias(singleton, "macaulay_duration", "macaulay");
  rb_define_singleton_method(klass, "modified", modified_discrete, 3);
  rb_define_alias(singleton, "modified_duration", "modified");
  rb_define_singleton_method(klass, "price", price_discrete, 3);
  rb_define_alias(singleton, "value", "price");
  rb_define_singleton_method(klass, "yield_to_maturity", yield_to_maturity_discrete, 3);
  rb_define_alias(singleton, "yield", "yield_to_maturity");
  rb_define_alias(singleton, "ytm", "yield_to_maturity");
}
