#include <ruby.h>

/* A native method */
static VALUE rupee_bonjour(VALUE self)
{
  return rb_str_new2("bonjour!");
}

void Init_rupee(void)
{
  VALUE klass = rb_define_class("Rupee", rb_cObject);

  rb_define_singleton_method(klass, "bonjour", rupee_bonjour, 0);
}
