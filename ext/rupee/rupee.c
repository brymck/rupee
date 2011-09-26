#include "rupee.h"

VALUE cRupee, sRupee;

/* Ruby calls this to load the extension */
void Init_rupee(void)
{
  cRupee = rb_define_class("Rupee", rb_cObject);
  sRupee = rb_singleton_class(cRupee);

  init_statistics();
  init_options();
}
