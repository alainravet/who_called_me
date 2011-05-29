class Foo
  def level_1
    level_0 # -1
  end
  def level_0
    who_called_me
  end

  def self.point_1
    FooFoo.point_1
  end
end
