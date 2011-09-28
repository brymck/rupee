#include "rupee.h"

void
init_future()
{
  VALUE klass, singleton;

#if 0
  value module = rb_define_module("rupee");
#endif

  klass = rb_define_class_under(module, "Future", rb_cObject);
  singleton = rb_singleton_class(klass);
}
