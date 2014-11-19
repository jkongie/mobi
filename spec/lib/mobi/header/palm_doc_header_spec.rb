require 'spec_helper'

require 'mobi/stream_slicer'
require 'mobi/metadata_streams'
require 'mobi/header/palm_doc_header'

describe Mobi::Header::PalmDocHeader do

  before :all do
    file = File.open('spec/fixtures/sherlock.mobi')
    stream    = Mobi::MetadataStreams.record_zero_stream(file)

    @header = Mobi::Header::PalmDocHeader.new stream
  end

  it 'gets the raw compression_type' do
    expect(@header.raw_compression_type).to eq(2)
  end

  it 'gets the compression type' do
    expect(@header.compression_type).to eq('PalmDOC')
  end

  it 'gets the text length' do
    expect(@header.text_length).to eq(57327)
  end

  it 'gets the record_count' do
    expect(@header.record_count).to eq(14)
  end

  it 'gets the record size' do
    expect(@header.record_size).to eq(4096)
  end

  it 'gets the raw encryption type' do
    expect(@header.raw_encryption_type).to eq(0)
  end

  it 'gets the encryption type' do
    expect(@header.encryption_type).to eq('None')
  end

end

