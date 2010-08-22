module WhoCalledMe
  module ArrayUtils

    def self.first_elements_with_common_prefix(arr, pre_len_to_ignore=0)
      arr.each_index do |i|
        # exclude the n first characters from the comparison <- remove them
        arr[i] =  arr[i][pre_len_to_ignore..-1]
      end

      [].tap do |results|
        first_line = arr.first
        results << first_line
        (0..arr.length-2).each do |i|
          line, next_line = arr[i], arr[i+1]

          next_line_not_in_same_code_tree = !StringUtils.common_substring?(line, next_line)
          next_line_not_in_same_code_tree ?
            break :
            (results << next_line)
        end
      end
    end

  end
end