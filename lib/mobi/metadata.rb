require 'forwardable'

module Mobi
  class Metadata
    extend Forwardable

    EXTH_RECORDS = %w(author publisher imprint description isbn subject
                      published_at review contributor rights subject_code type
                      source asin version)

    # Raw data stream
    attr_reader :data
    # Individual header classes for your reading pleasure.
    attr_reader :palm_doc_header, :mobi_header, :exth_header

    def initialize(file)
      @file = file
      @data = StreamSlicer.new(file)

      raise InvalidMobi, "The supplied file is not in a valid mobi format" unless bookmobi?

      @record_zero_stream = MetadataStreams.record_zero_stream(file)
      @palm_doc_header    = Header::PalmDocHeader.new @record_zero_stream
      @mobi_header        = Header::MobiHeader.new @record_zero_stream

      @exth_stream = MetadataStreams.exth_stream(file, @mobi_header.header_length)
      @exth_header = Header::ExthHeader.new @exth_stream
    end

    # Gets the title of the book.
    #
    # Returns a String.
    def title
      return @title if @title

      offset = @mobi_header.full_name_offset
      length = @mobi_header.full_name_length

      @title = @record_zero_stream[offset, length]
    end

    # Determines if the file is a valid mobi file.
    #
    # Returns true if the file is a valid MOBI.
    def bookmobi?
      @data[60, 8] == "BOOKMOBI"
    end

    # Delegate EXTH records types to the EXTH header.
    EXTH_RECORDS.each do |type|
      def_delegators :@exth_header, type.to_sym, type.to_sym
    end

    class InvalidMobi < ArgumentError;end;
  end
end