#include "rupee.h"

VALUE module;

/* Ruby calls this to load the extension */
void Init_rupee(void)
{
  module = rb_define_module("Rupee");

  init_statistics();
  init_options();
}
