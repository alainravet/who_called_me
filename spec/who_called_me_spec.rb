require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo_foo')

# Simplest call : no parameter
#
describe "who_called_me_data()" do
  before { WhoCalledMe.disable_puts}
  #don't restore in :after, because the puts happens in at_exit

  before  do
    @dir = File.dirname(__FILE__)[1..-1]
    FooFoo.new.foofoo ; @line = __LINE__
  end

  it "who_called_me_data() returns 2 fulltraces" do
    who_called_me_data[:all].should == [
      ["#{@dir}/who_called_me_spec.rb:#{@line}" ,
       "#{@dir}/fixtures/foo_foo.rb:5:in `foofoo'",
       "#{@dir}/fixtures/foo.rb:8:in `bar'"
      ],
      ["#{@dir}/who_called_me_spec.rb:#{@line}" ,
       "#{@dir}/fixtures/foo_foo.rb:6:in `foofoo'",
       "#{@dir}/fixtures/foo.rb:5:in `foo'"       ,
       "#{@dir}/fixtures/foo.rb:8:in `bar'"
      ]
    ]
  end

  it "who_called_me_data(:only_top=>true}) returns only the unique 1st lines" do
    who_called_me_data(:only_top=>true).should ==
      {
        :all => ["#{@dir}/who_called_me_spec.rb:#{@line}"]
      }
  end
end

# call with parameter
#   who_called_me_data('point 1')
#
describe "who_called_me_data('point 1')" do
  before { WhoCalledMe.disable_puts}
  #don't restore in :after, because the puts happens in at_exit

  before  do
    @dir = File.dirname(__FILE__)[1..-1]
    FooFoo.point_1; @line = __LINE__
    Foo   .point_1; @line2= __LINE__
  end

  it "who_called_me_data() returns 2 fulltraces" do

    who_called_me_data.should ==
      {
        'point 1' => [
                      ["#{@dir}/who_called_me_spec.rb:#{@line}" ,
                       "#{@dir}/fixtures/foo_foo.rb:10:in `point_1'"
                      ],
                      ["#{@dir}/who_called_me_spec.rb:#{@line2}" ,
                       "#{@dir}/fixtures/foo.rb:12:in `point_1'" ,
                       "#{@dir}/fixtures/foo_foo.rb:10:in `point_1'"
                      ]
                    ]
      }
  end

  it "who_called_me_data(:only_top=>true}) returns only the unique 1st lines" do
    who_called_me_data(:only_top=>true).should ==
      {
        'point 1' => ["#{@dir}/who_called_me_spec.rb:#{@line }",
                      "#{@dir}/who_called_me_spec.rb:#{@line2}"] 

      }
  end
end
