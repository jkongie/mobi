module Mobi
  class PalmDOCMetadata

    attr_accessor :data

    def initialize(stream)
      @data = StreamSlicer.new(stream)
    end

  end
end