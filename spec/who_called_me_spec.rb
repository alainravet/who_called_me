require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/foo_foo')

describe "WhoCalledMe" do
  before do
    FooFoo.new.foofoo
    @dir = File.dirname(__FILE__)[1..-1]
  end

  it "returns 2 fulltraces" do
    who_called_me_data.should == [
      ["#{@dir}/who_called_me_spec.rb:7" ,
       "#{@dir}/fixtures/foo_foo.rb:5:in `foofoo'",
       "#{@dir}/fixtures/foo.rb:8:in `bar'"
      ],
      ["#{@dir}/who_called_me_spec.rb:7" ,
       "#{@dir}/fixtures/foo_foo.rb:6:in `foofoo'",
       "#{@dir}/fixtures/foo.rb:5:in `foo'"       ,
       "#{@dir}/fixtures/foo.rb:8:in `bar'"
      ]
    ]
  end

  it "options{:only_top=>true} returns only the unique 1st lines" do
    who_called_me_data(:only_top=>true).should ==
      ["#{@dir}/who_called_me_spec.rb:7"]
  end

end
