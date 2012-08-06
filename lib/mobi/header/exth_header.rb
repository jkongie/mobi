module Mobi
  module Header
    class ExthHeader
      RECORD_TYPES = { 100 => :author, 101 => :publisher, 102 => :imprint, 103 => :description, 104 => :isbn, 105 => :subject,
                       106 => :published_at, 107 => :review, 108 => :contributor, 109 => :rights, 110 => :subject_code,
                       111 => :type, 112 => :source, 113 => :asin, 114 => :version }

      attr_reader *RECORD_TYPES.values

      def initialize(data)
        @data = data
        @record_count, = @data[8, 4].unpack('N*')

        define_data_methods
      end

      private

      def define_data_methods
        start = 12
        @record_count.times do
          record = ExthRecord.new(@data, start)

          if RECORD_TYPES.key?(record.code)
            instance_variable_set "@#{record.name}", record.value
          end

          start += record.length
        end
      end

      class ExthRecord

        attr_reader :code, :name, :length, :value

        def initialize(data, start)
          @code,   = data[start, 4].unpack('N*')[0].to_i
          @name    = ExthHeader::RECORD_TYPES[@code]
          @length, = data[start + 4, 4].unpack('N*')
          @value   = data[start + 8, length - 8]
        end
      end

    end
  end
end