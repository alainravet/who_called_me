require 'who_called_me/who_called_me.rb'

module Kernel
  def who_called_me
    nof_internal_methods_to_skim = 3  #this + WhoCalledMe._who_called_me + _fulltrace
    WhoCalledMe._who_called_me(nof_internal_methods_to_skim)
  end
  def who_called_me_data(options={})
    WhoCalledMe._who_called_me_data(options)
  end
end
