module WhoCalledMe

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
end
