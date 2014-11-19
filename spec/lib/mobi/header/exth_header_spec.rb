require 'spec_helper'

require 'mobi/stream_slicer'
require 'mobi/metadata_streams'
require 'mobi/header/mobi_header'
require 'mobi/header/exth_header'

describe Mobi::Header::ExthHeader do

  before :all do
    file   = File.open('spec/fixtures/sherlock.mobi')

    record_zero_stream = Mobi::MetadataStreams.record_zero_stream(file)
    mobi_header        = Mobi::Header::MobiHeader.new record_zero_stream
    exth_stream        = Mobi::MetadataStreams.exth_stream(file, mobi_header.header_length)

    @header = Mobi::Header::ExthHeader.new exth_stream
  end

  it 'gets the author' do
    expect(@header.author).to eq('Sir Arthur Conan Doyle')
  end

  it 'gets the book subject' do
    expect(@header.subject).to eq('Detective and mystery stories, English')
  end

  it 'gets the book rights' do
    expect(@header.rights).to eq('Public domain in the USA.')
  end

  it 'gets the book source' do
    expect(@header.source).to eq('http://www.gutenberg.org/files/2350/2350-h/2350-h.htm')
  end

end
