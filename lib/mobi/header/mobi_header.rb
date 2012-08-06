# Public: Parses the Mobi Header which follows the 16 bytes of the PalmDOC
# header.
module Mobi
  module Header
    class MobiHeader

      # Initialize the MobiHeader.
      #
      # data - A StreamSlicer which starts at record 0 of the PalmDOC.
      #
      # Returns self.
      def initialize(data)
        @data = data
      end

      # A MOBI identifier.
      #
      # Returns a String.
      def identifier
        @identifier ||= @data[16, 4]
      end

      # The length of the MOBI header.
      #
      # Returns a Fixnum.
      def header_length
        @header_length ||= @data[20, 4].unpack('N*')[0]
      end

      # The kind of Mobipocket file as returned from byte code.
      #
      # Returns a Fixnum.
      def raw_mobi_type
        @raw_mobi_type ||= @data[24, 4].unpack('N*')[0]
      end

      # The kind of Mobipocket file.
      #
      # Returns a String.
      def mobi_type
        { 2 => 'MOBIpocket Book',
          3 => 'PalmDoc Book',
          4 => 'Audio',
          232 => 'MOBIpocket',
          248 => 'KF8',
          257 => 'News',
          258 => 'News Feed',
          259 => 'News_Magazine',
          513 => 'PICS',
          514 => 'WORD',
          515 => 'XLS',
          516 => 'PPT',
          517 => 'TEXT',
          518 => 'HTML'
        }.fetch(raw_mobi_type)
      end

      # The text encoding as return from byte code.
      #
      # Returns a Fixnum.
      def raw_text_encoding
        @text_encoding ||= @data[28, 4].unpack('N*')[0]
      end

      # The text encoding.
      #
      # Returns a String.
      def text_encoding
        { 1252 => 'CP1252 (WinLatin1)',
          65001 => 'UTF-8'
        }.fetch(raw_text_encoding)
      end

      # The unique ID.
      #
      # Returns an Integer.
      def unique_id
        @unique_id ||= @data[32, 4].unpack('N*')[0]
      end

      # The version of the MOBIpocket format used in this file.
      #
      # Returns a String
      def file_version
        @file_version ||= @data[36, 4].unpack('N*')[0]
      end

      # The first record number (starting with 0) that is not the book's text.
      #
      # Returns an Integer.
      def first_non_book_index
        @first_non_book_index ||= @data[80, 4].unpack('N*')[0]
      end

      # Offset in record 0 (not from start of file) of the full name of the book.
      #
      # Returns an Integer.
      def full_name_offset
        @full_name_offset ||= @data[84, 4].unpack('N*')[0]
      end

      # Length in bytes of the full name of the book.
      #
      # Returns an Integer.
      def full_name_length
        @full_name_length ||= @data[88, 4].unpack('N*')[0]
      end

      # The raw book locale code. I believe this refers to a LCID code.
      #
      # The low byte is the main language: 09 = English.
      # The next byte is dialect: 08 = British, 04 = US.
      # Thus US English is 1033, UK English is 2057.
      #
      # Returns an Integer.
      def raw_locale_code
        @raw_locale_code ||= @data[92, 4].unpack('N*')[0]
      end

      # The minimum MOBIpocket version support needed to read this file.
      #
      # Returns an Integer.
      def minimum_supported_mobipocket_version
        @minimum_supported_mobipocket_version ||= @data[104, 4].unpack('N*')[0]
      end

      # The first record number (starting with 0) that contains an image. Image
      # records should be sequential.
      #
      # Returns an Integer.
      def first_image_index_record_number
        @first_image_index_record_number ||= @data[108, 4].unpack('N*')[0]
      end

      # The EXTH flag.
      #
      # If bit 6 is set, then there is an EXTH record.
      #
      # Returns a Fixnum, 1 or 0.
      def exth_flag
        @exth_flag ||= @data[128, 4].unpack('@3B8').first[1].to_i
      end

      # Does the book have an EXTH header?
      #
      # Returns true if the book has an EXTH header.
      def exth_header?
        exth_flag == 1
      end

    end
  end
end