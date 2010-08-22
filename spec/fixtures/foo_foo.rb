require File.expand_path(File.dirname(__FILE__) + '/foo')

class FooFoo
  def foofoo
    Foo.new.bar
    Foo.new.foo
  end
end

