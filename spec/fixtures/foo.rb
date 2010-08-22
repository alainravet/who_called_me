require File.expand_path(File.dirname(__FILE__) + '/../../lib/who_called_me')

class Foo
  def foo
    bar
  end
  def bar
    who_called_me
  end

  def self.point_1
    FooFoo.point_1
  end
end
