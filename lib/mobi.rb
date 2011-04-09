require File.expand_path('../mobi/stream_slicer', __FILE__)
require File.expand_path('../mobi/metadata', __FILE__)

module Mobi

  def self.metadata(file)
    Mobi::Metadata.new(file)
  end
  
end