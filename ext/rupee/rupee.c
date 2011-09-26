#include "rupee.h"

VALUE cRupee;

/* Ruby calls this to load the extension */
void Init_rupee(void)
{
  cRupee = rb_define_class("Rupee", rb_cObject);

  init_statistics();
  init_options();
}
