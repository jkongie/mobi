require 'spec_helper'

require 'mobi/stream_slicer'
require 'mobi/metadata_streams'
require 'mobi/header/mobi_header'

describe Header::MobiHeader do
  before :all do
    file = File.open('spec/fixtures/sherlock.mobi')
    stream    = Mobi::MetadataStreams.record_zero_stream(file)

    @header = Header::MobiHeader.new stream
  end

  it 'gets the identifier' do
    @header.identifier.should == 'MOBI'
  end

  it 'gets the length of the MOBI header' do
    @header.header_length.should == 232
  end

  it 'gets the mobi type as an integer' do
    @header.raw_mobi_type.should == 2
  end

  it 'gets the mobi type as a string' do
    @header.mobi_type.should == 'MOBIpocket Book'
  end

  it 'gets the raw text encoding' do
    @header.raw_text_encoding.should == 65001
  end

  it 'gets the text encoding' do
    @header.text_encoding.should == 'UTF-8'
  end

  it 'gets the unique id' do
    @header.unique_id.should == 1532466569
  end

  it 'gets the file version' do
    @header.file_version.should == 6
  end

  it 'gets the first non book index' do
    @header.first_non_book_index.should == 16
  end

  it 'gets the full name offset' do
    @header.full_name_offset.should == 688
  end

  it 'gets the full name length' do
    @header.full_name_length.should == 12
  end

  it 'gets the raw locale code' do
    @header.raw_locale_code.should == 9
  end

  it 'gets the minimum supported mobipocket version' do
    @header.minimum_supported_mobipocket_version.should == 6
  end

  it 'gets the first image index record number' do
    @header.first_image_index_record_number.should == 19
  end

  it 'gets the EXTH header flag' do
    @header.exth_flag.should == 1
  end

  it 'checks if there an EXTH header exists' do
    @header.exth_header?.should be_true
  end

end
