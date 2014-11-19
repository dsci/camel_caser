require File.join(File.dirname(__FILE__), "app")
require File.join(File.dirname(__FILE__), '..',
                                          '..', 
                                          '..',
                                          'lib', 
                                          'camel_caser.rb')

use CamelCaser::Middleware

run App.new
