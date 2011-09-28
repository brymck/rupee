#include "rupee.h"

double *
rtofary(rary)
  VALUE rary;
{
  int len, i;
  double *result;
  VALUE *ary;

  ary = RARRAY_PTR(rary);
  len = RARRAY_LEN(rary);
  result = realloc(result, len);

  for (i = 0; i < len; i++)
    result[i] = NUM2DBL(ary[i]);

  return result;
}

