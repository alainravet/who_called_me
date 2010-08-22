module Kernel
  def who_called_me
    nof_internal_methods_to_skim = 3  #this + WhoCalledMe._who_called_me + _fulltrace
    WhoCalledMe._who_called_me(nof_internal_methods_to_skim)
  end
  def who_called_me_data(options={})
    WhoCalledMe._who_called_me_data(options)
  end
end

#------------------------------------------------------------------------------

module WhoCalledMe

  @@__who_called_me_accumul = []

  def self._who_called_me(nof_internal_methods_to_skim=1+1) # this + _fulltrace
    fulltrace = _fulltrace
    trace = ArrayUtils.first_elements_with_common_prefix(fulltrace, 1)
    trace = trace[nof_internal_methods_to_skim..-1]
    trace.reverse!

    _who_called_me_data << trace
    trace
  end

  def self._fulltrace
    raise
  rescue
    $!.backtrace
  end

  def self._who_called_me_data(options={})
    all = @@__who_called_me_accumul
    if options[:only_top]
      all.collect{|trace| trace.first }.uniq
    else
      all
    end
  end
end

#------------------------------------------------------------------------------
module StringUtils
  # http://stackoverflow.com/questions/1916218/find-the-longest-common-starting-substring-in-a-set-of-strings
  def self.common_substring(a, b)
    difference = a.to_str.each_char.with_index.find { |ch, idx|
      b[idx].nil? or ch != b[idx].chr
    }
    difference ? b[0, difference.last] : b
  end
end

#------------------------------------------------------------------------------
module ArrayUtils
  # def common_substring
  #   self.inject(nil) { |memo, str| memo.nil? ? str : memo & str }.to_s
  # end

  def self.first_elements_with_common_prefix(arr, pre_len_to_ignore=0)
    def self.filtr(s, pre_len_to_ignore)
      s[pre_len_to_ignore..-1]
    end
    [].tap do |results|
      results << filtr(arr.first, pre_len_to_ignore)
      arr.each_with_index do |el, i|
        break if i == (arr.length - 1)
        el      = filtr(el, pre_len_to_ignore)
        next_el = filtr(arr[i+1], pre_len_to_ignore)
        common = StringUtils.common_substring(el, next_el)
        break unless 1 <= common.length
        results << next_el
      end
    end
  end
end
