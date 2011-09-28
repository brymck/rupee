#include "rupee.h"

double
simple_df(r, time, discrete)
  double r, time;
  bool discrete;
{
  if (discrete)
    return 1.0 / pow(1.0 + r, time);
  else
    return exp(-r * time);
}

double *
rtofa(dest, src, len)
  double *dest;
  VALUE src;
  int len;
{
  int i;
  VALUE *ary;

  ary = RARRAY_PTR(src);

  for (i = 0; i < len; i++)
    dest[i] = NUM2DBL(ary[i]);

  return dest;
}

double
avg(x, y)
  double x, y;
{
  return 0.5 * (x + y);
}
