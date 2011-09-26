#include <ruby.h>
#include "statistics.h"
#include "european.h"

/* Ruby calls this to load the extension */
void Init_rupee(void)
{
  /* Assuming that we haven't defined Rupee */
  VALUE klass = rb_define_class("Rupee", rb_cObject);

  rb_define_singleton_method(klass, "cnd", rupee_cnd, 1);
  rb_define_singleton_method(klass, "black76", rupee_black76, 6);
}
