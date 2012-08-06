# Public:

module Header
  class PalmDocHeader

    # Initializes the PalmDOC header.
    #
    # data - A StreamSlicer which starts at the PalmDOC header.
    #
    # Returns self.
    def initialize(data)
      @data = data
    end

    # The compression type as returned from byte code.
    #
    # Returns a Fixnum.
    def raw_compression_type
      @compression_type ||= @data[0, 2].unpack('n*')[0]
    end

    # The compression type.
    #
    # Returns a Fixnum.
    def compression_type
      { 1 => 'None',
        2 => 'PalmDOC',
        17480 => 'HUFF/CDIC'
      }.fetch(raw_compression_type)
    end

    # The uncompressed length of the entire text of the book.
    #
    # Returns a Fixnum.
    def text_length
      @text_length ||= @data[4, 4].unpack('N*')[0]
    end

    # Number of PDB records used for the text of the book.
    #
    # Returns a Fixnum.
    def record_count
      @record_count ||= @data[8, 2].unpack('n*')[0]
    end

    # Maximum size of each record containing text. Note that this always
    # returns 4096.
    #
    # Returns a Fixnum.
    def record_size
      @record_size ||= @data[10, 2].unpack('n*')[0]
    end

    # The encryption type as returned from byte code.
    #
    # Returns a Fixnum
    def raw_encryption_type
      @encryption_type ||= @data[12, 2].unpack('n*')[0]
    end

    # The encryption type.
    #
    # Returns a String.
    def encryption_type
      { 0 => 'None',
        1 => 'Old MOBIpocket',
        2 => 'MOBIpocket'
      }.fetch(raw_encryption_type)
    end

  end
end