module WhoCalledMe
  module StringUtils

    def self.common_substring?(a, b)
      1 <= common_substring(a, b).length
    end

    def self.common_substring(a, b)
      difference = a.to_str.each_char.with_index.find { |ch, idx|
        b[idx].nil? or ch != b[idx].chr
      }
      difference ? b[0, difference.last] : b
    end

  end
end