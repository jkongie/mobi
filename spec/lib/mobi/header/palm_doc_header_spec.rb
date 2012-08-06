require 'spec_helper'

require 'mobi/stream_slicer'
require 'mobi/metadata_streams'
require 'mobi/header/palm_doc_header'

describe 'PalmDocHeader' do

  before :all do
    file = File.open('spec/fixtures/sherlock.mobi')
    stream    = Mobi::MetadataStreams.record_zero_stream(file)

    @header = Header::PalmDocHeader.new stream
  end

  it 'gets the raw compression_type' do
    @header.raw_compression_type.should == 2
  end

  it 'gets the compression type' do
    @header.compression_type.should == 'PalmDOC'
  end

  it 'gets the text length' do
    @header.text_length.should == 57327
  end

  it 'gets the record_count' do
    @header.record_count.should == 14
  end

  it 'gets the record size' do
    @header.record_size.should == 4096
  end

  it 'gets the raw encryption type' do
    @header.raw_encryption_type.should == 0
  end

  it 'gets the encryption type' do
    @header.encryption_type.should == 'None'
  end

end

