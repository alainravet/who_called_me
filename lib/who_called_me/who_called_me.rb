
module WhoCalledMe
  def self.puts_all_formatted_traces
    return if _who_called_me_data.empty?
    return if @@__disable_puts
    _who_called_me_data.keys.each do |key|
      _who_called_me_data[key].each do |trace|
         puts formatted_trace(trace).join("\n")
      end
    end
  end
end

module WhoCalledMe
  @@__who_called_me_accumul_h = {}
  @@__disable_puts          = false

  def self.disable_puts ; @@__disable_puts = true  end
  def self.enable_puts  ; @@__disable_puts = false end


  def self._who_called_me(msg=nil, nof_internal_methods_to_skim=1+1) # this + _fulltrace
    trace = first_elements_with_common_prefix(fulltrace, 1)
    trace = trace[nof_internal_methods_to_skim..-1]
    record(msg || :all, trace)
    trace
  end

  def self.record(key, trace)
    @@__who_called_me_accumul_h[key] ||= []
    @@__who_called_me_accumul_h[key] << trace
  end


  def self._who_called_me_data(options={})
    if options[:only_top]
      {}.tap do |result|
        @@__who_called_me_accumul_h.each do |key, traces|
          result[key] = traces.collect{|trace| trace.first }.uniq
        end
      end
    else
      @@__who_called_me_accumul_h
    end
  end


  # used by tests only
  def self.reset_for_next_test
    @@__who_called_me_accumul_h = {}
    @@__disable_puts          = false
  end


end
