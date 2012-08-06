require 'mobi/stream_slicer'
require 'mobi/metadata'
require 'mobi/metadata_streams'
require 'mobi/header/palm_doc_header'
require 'mobi/header/mobi_header'
require 'mobi/header/exth_header'

module Mobi

  def self.metadata(file)
    Mobi::Metadata.new(file)
  end

end