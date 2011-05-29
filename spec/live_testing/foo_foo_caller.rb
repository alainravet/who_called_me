$:.push File.expand_path("../../../lib", __FILE__)
$:.push File.expand_path("../../fixtures", __FILE__)

require 'who_called_me'
require 'foo_foo'

FooFoo.new.foofoo
#FooFoo.point_1
Foo.point_1
