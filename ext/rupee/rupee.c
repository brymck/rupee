#include "rupee.h"

VALUE module;

void
Init_rupee()
{
  module = rb_define_module("Rupee");

  init_distribution();
  init_option();
  init_bond();
}
