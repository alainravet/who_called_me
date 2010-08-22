module WhoCalledMe
  module TraceUtils

    def self.fulltrace
      raise
    rescue
      $!.backtrace
    end

  end
end