#include "rupee.h"

VALUE module;

void Init_rupee(void)
{
  module = rb_define_module("Rupee");

  init_statistics();
  init_options();
}
