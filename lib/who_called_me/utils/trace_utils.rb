module WhoCalledMe
  module Utils
    module TraceUtils

      def fulltrace
        raise
      rescue
        $!.backtrace
      end

      def formatted_trace(trace)
        first_line, last_line = trace.first, trace.last
        trace.shift
        res = []
        res << "\n"
        res += boxed_code_snippet_around(first_line)
        res << '  was called by :'
        res += indented_call_trace(trace)
        res += indent(boxed_code_snippet_around(last_line), :prefix => '   ')
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