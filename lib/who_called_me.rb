$:.push File.expand_path(File.dirname(__FILE__))

require 'who_called_me/who_called_me.rb'
Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/**/utils/*.rb").each { |f| load(f) }


module Kernel
  def who_called_me(msg=nil)
    nof_internal_methods_to_skim = 3 #3  #this + WhoCalledMe._who_called_me + _fulltrace
    nof_internal_methods_to_skim = 3 #3  #this + WhoCalledMe._who_called_me + _fulltrace
    WhoCalledMe._who_called_me(msg, nof_internal_methods_to_skim)
  end
  def who_called_me_data(options={})
    WhoCalledMe._who_called_me_data(options)
  end
end

at_exit do
  if !who_called_me_data.empty?
    WhoCalledMe.puts_all_formatted_traces
  end
end
