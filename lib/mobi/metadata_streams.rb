module Mobi
  module MetadataStreams

    # Creates a stream starting at the PalmDOC header
    #
    # Returns a StreamSlicer.
    def self.palm_doc_header_stream(file)
      data = StreamSlicer.new(file)

      offset = 78
      start, = data[offset, 4].unpack('N*')
      stop,  = data[offset + 8, offset + 12].unpack('N*');

      StreamSlicer.new(file, start, stop)
    end

  end
end