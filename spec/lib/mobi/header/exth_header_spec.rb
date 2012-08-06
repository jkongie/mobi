require 'spec_helper'

require 'mobi/stream_slicer'
require 'mobi/metadata_streams'
require 'mobi/header/mobi_header'
require 'mobi/header/exth_header'

describe Header::ExthHeader do

  before :all do
    file   = File.open('spec/fixtures/sherlock.mobi')

    record_zero_stream = Mobi::MetadataStreams.record_zero_stream(file)
    mobi_header        = Header::MobiHeader.new record_zero_stream
    exth_stream        = Mobi::MetadataStreams.exth_stream(file, mobi_header.header_length)

    @header = Header::ExthHeader.new exth_stream
  end

  it 'gets the author' do
    @header.author.should == 'Sir Arthur Conan Doyle'
  end

  it 'gets the book subject' do
    @header.subject.should == 'Detective and mystery stories, English'
  end

  it 'gets the book rights' do
    @header.rights.should == 'Public domain in the USA.'
  end

  it 'gets the book source' do
    @header.source.should == 'http://www.gutenberg.org/files/2350/2350-h/2350-h.htm'
  end

end
