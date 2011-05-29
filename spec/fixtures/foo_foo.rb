require File.expand_path(File.dirname(__FILE__) + '/foo')

class FooFoo
  def foofoo
    Foo.new.level_0
    Foo.new.level_1
  end

  def self.point_1
    who_called_me('point 1')
  end
end