#include "rupee.h"

VALUE module, superklass;

void
Init_rupee()
{
  module = rb_define_module("Rupee");
  superklass = rb_define_class_under(module, "Security", rb_cObject);

  init_distribution();
  init_option();
  init_bond();
  init_future();
}
