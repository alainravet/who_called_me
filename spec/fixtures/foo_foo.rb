require File.expand_path(File.dirname(__FILE__) + '/foo')

class FooFoo
  def foofoo
    Foo.new.bar
    Foo.new.foo
  end

  def self.point_1
    who_called_me('point 1')
  end
end