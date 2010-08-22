require File.dirname(__FILE__) + '/string_utils'
require File.dirname(__FILE__) + '/array_utils'
require File.dirname(__FILE__) + '/trace_utils'

module WhoCalledMe

  @@__who_called_me_accumul = []
  @@__disable_puts          = false

  def self.disable_puts ; @@__disable_puts = true  end
  def self.enable_puts  ; @@__disable_puts = false end


  def self._who_called_me(msg=nil, nof_internal_methods_to_skim=1+1) # this + _fulltrace
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


  def self.puts_formatted_traces
    return if _who_called_me_data.empty?
    return if @@__disable_puts
    l0 = '-'*99
    puts l0
    puts 'who_called_me report :'
    puts '======================'
    _who_called_me_data.each do |trace|
      puts
      puts trace.shift
      puts '  was called by :'
      padding = ''
      trace.each do |line|
        padding += '  '
        puts "  .#{padding}#{line}"
      end
    end
    puts
    puts l0
  end
end
