require File.dirname(__FILE__) + '/string_utils'
require File.dirname(__FILE__) + '/array_utils'
require File.dirname(__FILE__) + '/trace_utils'

module WhoCalledMe

  @@__who_called_me_accumul = []

  def self._who_called_me(nof_internal_methods_to_skim=1+1) # this + _fulltrace
    fulltrace = TraceUtils.fulltrace
    trace = ArrayUtils.first_elements_with_common_prefix(fulltrace, 1)
    trace = trace[nof_internal_methods_to_skim..-1]
    trace.reverse!

    _who_called_me_data << trace
    trace
  end

  def self._who_called_me_data(options={})
    all = @@__who_called_me_accumul
    if options[:only_top]
      all.collect{|trace| trace.first }.uniq
    else
      all
    end
  end
end

