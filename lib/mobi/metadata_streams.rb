module Mobi
  module MetadataStreams

    # Creates a stream starting at the Record 0 in the PalmDOC.
    #
    # Returns a StreamSlicer.
    def self.record_zero_stream(file)
      data = StreamSlicer.new(file)

      start, stop = record_zero_endpoints(data)

      StreamSlicer.new(file, start, stop)
    end

    #
    def self.exth_stream(file, header_length)
      record_zero_stream = record_zero_stream(file)

      record_zero_offset     = record_zero_stream.start
      palm_doc_header_length = 16

      exth_off = record_zero_offset +
                 palm_doc_header_length +
                 header_length

      StreamSlicer.new(file, exth_off, record_zero_stream.stop)
    end

    private

    # Determines the start and end points of Record 0 in the PalmDOC. The start point
    # is returned as the first value in the array, and the end point as the
    # second value.
    #
    # Returns an Array.
    def self.record_zero_endpoints(data)
      offset = 78
      start, = data[offset, 4].unpack('N*')
      stop,  = data[offset + 8, offset + 12].unpack('N*');
      [start, stop]
    end


  end
end