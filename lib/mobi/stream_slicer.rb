module Mobi
  class StreamSlicer

    attr_reader :stream, :length
    attr_accessor :start, :stop

    def initialize(stream, start=0, stop=nil)
      @stream = stream
      @start  = start
      if stop.nil?
        stream.seek(0, 2)
        stop = stream.tell
      end
      @stop = stop
      @length  = stop - start
    end

    def [](offset, bytes=1)
      stream = @stream
      base = @start
      
      if bytes == 1
        stream.seek(base + offset)
        return stream.read(1)
      end
      
      start = offset
      stop  = offset + bytes
      
      # Reverse if you want to pass in negative bytes
      start, stop = stop, start if bytes < 0
      
      size = stop - start
      return "" if size <= 0
      
      stream.seek(base + start)
      data = stream.read(size)
      return data
    end
  end
end