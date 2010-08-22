$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'who_called_me'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  config.before(:each) do
    WhoCalledMe.reset
  end
  
end

def capture_stdout
  @@original_stdout = STDOUT
  $stdout = StringIO.new
end

def restore_stdout
  $stdout = @@original_stdout
end
