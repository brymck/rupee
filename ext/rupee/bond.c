#include "rupee.h"

double
bond_price(cf_times, cfs, r, len)
  double *cf_times, *cfs, r;
  int len;
{
  double p, *cft;
  int i;

  p = 0;

  for (i = 0; i < len; i++)
  	p += exp(-r * cf_times[i]) * cfs[i];

  return p;
};

static VALUE
price(self, rcf_times, rcfs, rr)
  VALUE self, rcf_times, rcfs, rr;
{
  int len = RARRAY_LEN(rcfs);
  double r, cf_times[len], cfs[len];
  
  r = NUM2DBL(rr);
  rtofa(cf_times, rcf_times, len);
  rtofa(cfs, rcfs, len);

  return rb_float_new(bond_price(cf_times, cfs, r, len));
}

static VALUE
convexity(self, rcf_times, rcfs, rr)
  VALUE self, rcf_times, rcfs, rr;
{
  int len = RARRAY_LEN(rcfs);
  double r, C, B, cf_times[len], cfs[len];
  int i;

  rtofa(cf_times, rcf_times, len);
  rtofa(cfs, rcfs, len);
  r = NUM2DBL(rr);
  C = 0;

  for (i = 0; i < len; i++)
  	C += cfs[i] * pow(cf_times[i], 2) * exp(-r * cf_times[i]);

  B = bond_price(cf_times, cfs, r, len);

  return rb_float_new(C / B);
};

static VALUE
duration(self, rcf_times, rcfs, rr)
  VALUE self, rcf_times, rcfs, rr;
{
  double r, S, D1;
  int i, cfs_len;

  VALUE *cf_times = RARRAY_PTR(rcf_times);
  VALUE *cfs = RARRAY_PTR(rcfs);
  cfs_len = RARRAY_LEN(rcfs);
  r = NUM2DBL(rr);
  S = 0;
  D1 = 0;

  for (i = 0; i < cfs_len; i++) {
    double cfti, cfi, dcfi;

    cfti = NUM2DBL(cf_times[i]);
    cfi = NUM2DBL(cfs[i]);
    dcfi = cfi * exp(-r * cfti);

  	S  += dcfi;
 	  D1 += cfti * dcfi;
  }

  return rb_float_new(D1 / S);
}

void
init_bond()
{
  VALUE klass, singleton;

#if 0
  value module = rb_define_module("rupee");
#endif

  klass = rb_define_class_under(module, "Bond", rb_cObject);
  singleton = rb_singleton_class(klass);

  rb_define_singleton_method(klass, "convexity", convexity, 3);
  rb_define_singleton_method(klass, "duration", duration, 3);
  rb_define_singleton_method(klass, "price", price, 3);
}
