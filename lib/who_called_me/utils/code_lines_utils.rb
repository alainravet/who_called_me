module WhoCalledMe
  module Utils
    module CodeLinesUtils

      # input = Users/ara//foo.rb:3:in `level_1'
      # => ['/ara//foo.rb',3,"in `level_1'"]
      def file_and_line_details(called_line)
        file, line_nbr, context  = called_line.split(':')
        ['/'+file, line_nbr.to_i, context]
      end


      def boxed_code_snippet_around(called_line)
        file, line_nbr, context = file_and_line_details(called_line)
        formatted_code_snippet = numbered_lines_section_around(file, line_nbr)
        #formatted_code_snippet = WhoCalledMe::Utils::FileUtils.numbered_lines_section_around(file, line_nbr)
        formatted_code_snippet.flatten #TODO : fix the numbered_lines_section_around so that it returns a flat array
      end


      # Usage:
      #   puts numbered_lines_section_around('/todo.txt', 9).join("\n")
      #   puts numbered_lines_section_around('/todo.txt', 9, padding = 3).join("\n")
      #
      def numbered_lines_section_around(filename, center_line_number, padding = 1)
        lines_range =   range_around(center_line_number, padding)
        max_digits  =   max_digits_in(lines_range)

        all_lines   = File.open(filename).readlines # TODO : optimize (don't read lines after the range limit)

        filename_line = "| File : #{filename}"
        hr            = '+' + '-'*filename_line.length

        [].tap do |formatted_lines|
          formatted_lines << hr
          formatted_lines << filename_line
          formatted_lines << hr
          formatted_lines << lines_range.collect { |nbr|
            raw_line      =   all_lines[nbr-1].chomp
            numbered_line =   "| line %#{max_digits}s : %s" % [nbr, raw_line]
            (center_line_number==nbr) ?
                colour_current_line(numbered_line) :
                numbered_line
          }
          formatted_lines << hr
        end
      end

      private

      def range_around(center_line_number, padding)
        (center_line_number - padding..center_line_number + padding)
      end

      def max_digits_in(lines_range)
        1 + Math.log10(1+lines_range.last).to_int
      end

    end
  end
end

WhoCalledMe.send :extend, WhoCalledMe::Utils::CodeLinesUtils