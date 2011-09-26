#include <ruby.h>

/* A native method */
static VALUE rupee_bonjour(VALUE self)
{
  return rb_str_new2("bonjour!");
}

/* Ruby calls this to load the extension */
void Init_rupee(void)
{
  /* Assuming that we haven't defined Rupee */
  VALUE klass = rb_define_class("Rupee", rb_cObject);

  /* The rupee_bonjour method can be called as Rupee.bonjour */
  rb_define_singleton_method(klass, "bonjour", rupee_bonjour, 0);
}
