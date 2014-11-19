require 'spec_helper'

require 'mobi/stream_slicer'
require 'mobi/metadata_streams'
require 'mobi/header/mobi_header'

describe Mobi::Header::MobiHeader do
  before :all do
    file = File.open('spec/fixtures/sherlock.mobi')
    stream    = Mobi::MetadataStreams.record_zero_stream(file)

    @header = Mobi::Header::MobiHeader.new stream
  end

  it 'gets the identifier' do
    expect(@header.identifier).to eq('MOBI')
  end

  it 'gets the length of the MOBI header' do
    expect(@header.header_length).to eq(232)
  end

  it 'gets the mobi type as an integer' do
    expect(@header.raw_mobi_type).to eq(2)
  end

  it 'gets the mobi type as a string' do
    expect(@header.mobi_type).to eq('MOBIpocket Book')
  end

  it 'gets the raw text encoding' do
    expect(@header.raw_text_encoding).to eq(65001)
  end

  it 'gets the text encoding' do
    expect(@header.text_encoding).to eq('UTF-8')
  end

  it 'gets the unique id' do
    expect(@header.unique_id).to eq(1532466569)
  end

  it 'gets the file version' do
    expect(@header.file_version).to eq(6)
  end

  it 'gets the first non book index' do
    expect(@header.first_non_book_index).to eq(16)
  end

  it 'gets the full name offset' do
    expect(@header.full_name_offset).to eq(688)
  end

  it 'gets the full name length' do
    expect(@header.full_name_length).to eq(12)
  end

  it 'gets the raw locale code' do
    expect(@header.raw_locale_code).to eq(9)
  end

  it 'gets the minimum supported mobipocket version' do
    expect(@header.minimum_supported_mobipocket_version).to eq(6)
  end

  it 'gets the first image index record number' do
    expect(@header.first_image_index_record_number).to eq(19)
  end

  it 'gets the EXTH header flag' do
    expect(@header.exth_flag).to eq(1)
  end

  it 'checks if there an EXTH header exists' do
    expect(@header.exth_header?).to be true
  end

end
