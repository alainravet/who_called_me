require File.dirname(__FILE__) + '/string_utils'
require File.dirname(__FILE__) + '/array_utils'
require File.dirname(__FILE__) + '/trace_utils'

module WhoCalledMe

  @@__who_called_me_accumul_h = {}
  @@__disable_puts          = false

  def self.disable_puts ; @@__disable_puts = true  end
  def self.enable_puts  ; @@__disable_puts = false end


  def self._who_called_me(msg=nil, nof_internal_methods_to_skim=1+1) # this + _fulltrace
    fulltrace = TraceUtils.fulltrace
    trace = ArrayUtils.first_elements_with_common_prefix(fulltrace, 1)
    trace = trace[nof_internal_methods_to_skim..-1]
    trace.reverse!

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


  def self.puts_formatted_traces
    return if _who_called_me_data.empty?
    return if @@__disable_puts
    l0 = '-'*99
    puts l0
    puts 'who_called_me report :'
    puts '======================'
    _who_called_me_data.keys.each do |key|
      puts
      puts "+----------------------------"
      puts (key == :all) ? '| who_called_me' : "| who_called_me(#{key})"
      puts "+----------------------------"
      _who_called_me_data[key].each do |trace|
        puts
        puts trace.shift
        puts '  was called by :'
        padding = ''
        trace.each do |line|
          padding += '  '
          puts "  .#{padding}#{line}"
        end
      end
    end
    puts
    puts l0
  end

  # used by tests only
  def self.reset
    @@__who_called_me_accumul_h = {}
    @@__disable_puts          = false
  end
end
