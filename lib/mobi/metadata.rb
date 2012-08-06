module Mobi
  class Metadata
    EXTH_RECORDS = { 100 => :author, 101 => :publisher, 102 => :imprint, 103 => :description, 104 => :isbn, 105 => :subject,
                     106 => :published_at, 107 => :review, 108 => :contributor, 109 => :rights, 110 => :subject_code,
                     111 => :type, 112 => :source, 113 => :asin, 114 => :version }

    attr_reader *EXTH_RECORDS.values

    attr_accessor :stream, :data, :exth
    attr_reader   :exth_records

    # Individual header classes for your reading pleasure.
    attr_reader :palm_doc_header, :mobi_header, :exth_header

    class InvalidMobi < ArgumentError;end;

    def initialize(file)
      @stream       = file
      @data         = StreamSlicer.new(file)
      @exth_records = []

      raise InvalidMobi, "The supplied file is not in a valid mobi format" unless bookmobi?

      @record_zero_stream = MetadataStreams.record_zero_stream(file)
      @palm_doc_header    = Header::PalmDocHeader.new @record_zero_stream
      @mobi_header        = Header::MobiHeader.new @record_zero_stream

      @exth_stream = MetadataStreams.exth_stream(file, @mobi_header.header_length)
      @exth_header = Header::ExthHeader.new @exth_stream

      @exth  = MetadataStreams.exth_stream(file, @mobi_header.header_length)

      store_mobi_data
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
    # Mobi files have a
    #
    # Returns true if the file is a valid mobi file
    def bookmobi?
      @data[60, 8] == "BOOKMOBI"
    end

    def store_mobi_data
      record_count, = @exth[8, 4].unpack('N*')
      start = 12
      record_count.times do
        code, = @exth[start, 4].unpack('N*')
        code  = code.to_i

        length, = @exth[start + 4, 4].unpack('N*')
        value   = @exth[start + 8, length - 8]

        if EXTH_RECORDS[code]
          instance_variable_set "@#{EXTH_RECORDS[code].to_s}", value
          @exth_records << EXTH_RECORDS[code]
        end

        start += length
      end
    end

  end
end