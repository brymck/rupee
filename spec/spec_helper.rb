puts <<-eos
       Test notifier gem not foun
     eos


$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require "rupee"
