module WhoCalledMe
  def self.puts_all_formatted_traces
    return if _recorded_calls_data.empty?
    return if @@__disable_puts
    @processed_first_lines = []
    _recorded_calls_data.keys.each do |key|
      _recorded_calls_data[key].each do |trace|
         puts formatted_trace(trace, @processed_first_lines).join("\n")
      end
    end
  end
end

class Accumulator
  attr_reader :data
  def initialize
    @data = {}
  end

  def keys
    data.keys
  end

  def data_only_top
    {}.tap do |result|
      keys.each do |key|
        traces = data[key]
        result[key] = traces.collect{|trace| trace.first }.uniq
      end
    end
  end

  def record_trace(key, trace)
    data[key] ||= []
    data[key] << trace
  end

  def [](key)
    data[key]
  end

end

module WhoCalledMe

  @@_accumulator            = Accumulator.new
  @@__disable_puts          = false

  def self.accumulator  ; @@_accumulator           end

  def self.disable_puts ; @@__disable_puts = true  end
  def self.enable_puts  ; @@__disable_puts = false end

  def self.record_i_was_called(key=:all, nof_internal_methods_to_skim=1+1) # this + _fulltrace
    trace = first_elements_with_common_prefix(fulltrace, 1)
    trace = trace[nof_internal_methods_to_skim..-1]
    accumulator.record_trace(key, trace)
  end

  def self._recorded_calls_data(options={})
    options[:only_top] ?
      accumulator.data_only_top :
      accumulator.data
  end

  # used by tests only
  def self.reset_for_next_test
    reset_accumulator_for_next_test
    @@__disable_puts          = false
  end

  def self.reset_accumulator_for_next_test
    @@_accumulator ||= Accumulator.new
  end
end