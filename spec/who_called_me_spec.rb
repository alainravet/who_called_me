require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo_foo')

describe "who_called_me_data()" do
  before { WhoCalledMe.disable_puts}
  #don't restore in :after, because the puts happens in at_exit

  before  do
    @dir = File.dirname(__FILE__)[1..-1]
    FooFoo.new.foofoo
  end

  it "who_called_me_data() returns 2 fulltraces" do
    who_called_me_data.should == [
      ["#{@dir}/who_called_me_spec.rb:11" ,
       "#{@dir}/fixtures/foo_foo.rb:5:in `foofoo'",
       "#{@dir}/fixtures/foo.rb:8:in `bar'"
      ],
      ["#{@dir}/who_called_me_spec.rb:11" ,
       "#{@dir}/fixtures/foo_foo.rb:6:in `foofoo'",
       "#{@dir}/fixtures/foo.rb:5:in `foo'"       ,
       "#{@dir}/fixtures/foo.rb:8:in `bar'"
      ]
    ]
  end

  it "who_called_me_data(:only_top=>true}) returns only the unique 1st lines" do
    who_called_me_data(:only_top=>true).should ==
      ["#{@dir}/who_called_me_spec.rb:11"]
  end
end
