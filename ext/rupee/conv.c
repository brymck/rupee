#include "rupee.h"

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
