module WhoCalledMe
  module Utils
    module TraceUtils

      def fulltrace
        raise
      rescue
        $!.backtrace
      end

      def formatted_trace(trace, processed_first_lines)
        first_line, last_line = trace.first, trace.last
        already_recorded_a_trace_for_this_target = processed_first_lines.include?(first_line)
        trace.shift
        res = []
        res << "\n"

        unless already_recorded_a_trace_for_this_target
          processed_first_lines << first_line
          short_form = already_recorded_a_trace_for_this_target
          res += boxed_code_snippet_around(first_line)  unless short_form
        end
        res << '  was called by :'
        res += indented_call_trace(trace)
        res += indent(boxed_code_snippet_around(last_line), :prefix => ' '*6)
        res
      end


      def indented_call_trace(trace, base_padding='  ')
        padding = ''
        [].tap do |indented_trace|
          trace.each_with_index { |line, i| indented_trace << "  . #{base_padding*i}#{line}" }
        end
      end

    end
  end
end
WhoCalledMe.send :extend, WhoCalledMe::Utils::TraceUtils