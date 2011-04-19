module Mobi
  class Metadata
    DRM_KEY_SIZE = 48
    
    EXTH_RECORDS = { 100 => :author, 101 => :publisher, 102 => :imprint, 103 => :description, 104 => :isbn, 105 => :subject,
                     106 => :published_at, 107 => :review, 108 => :contributor, 109 => :rights, 110 => :subject_code, 
                     111 => :type, 112 => :source, 113 => :asin, 114 => :version}
    attr_reader *EXTH_RECORDS.values
    attr_reader :title

    attr_accessor :stream, :data, :mobi, :exth
    attr_reader :exth_records

    def initialize(stream)
      @stream = stream
      @data = StreamSlicer.new(stream)
      @exth_records = []
      return unless bookmobi?
      @mobi = mobi_stream    
      @title = read_title
      @exth = exth_stream
    
      store_mobi_data
    end
    
    def bookmobi?
      @data[60, 8] == "BOOKMOBI"
    end
    
    def mobi_stream
      offset = 78
      start, = @data[offset, 4].unpack('N*')
      stop,  = @data[offset + 8, offset + 12].unpack('N*')
      StreamSlicer.new(self.stream, start, stop)
    end
    
    def exth_stream
      exth_off = @mobi[20, 4].unpack('N*').first + 16 + @mobi.start
      StreamSlicer.new(stream, exth_off, @mobi.stop)
    end
    
    def read_title
      offset, = @mobi[84, 4].unpack('N*')
      length, = @mobi[88, 4].unpack('N*')
      @mobi[offset.to_i, length.to_i]
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