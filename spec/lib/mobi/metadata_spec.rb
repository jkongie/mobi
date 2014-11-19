require 'spec_helper'

require 'mobi'

describe Mobi::Metadata do
  before :all do
    @file = File.open('spec/fixtures/sherlock.mobi')
  end


  context 'initialization' do
    it 'instantiates a StreamSlicer from the file' do
      metadata = Mobi::Metadata.new(@file)

      expect(metadata.data).to be_instance_of(Mobi::StreamSlicer)
    end

    it 'raises an exception if the book is not a mobi' do
      any_instance_of(Mobi::Metadata) do |m|
        mock(m).bookmobi? { false }
      end

      expect{ Mobi::Metadata.new(@file) }.to raise_exception(Mobi::Metadata::InvalidMobi)
    end

    context 'instantiating headers' do
      before :all do
        @metadata = Mobi::Metadata.new(@file)
      end

      it 'instantiates a palm doc header' do
        expect(@metadata.palm_doc_header).to be_a Mobi::Header::PalmDocHeader
      end

      it 'instantiates a mobi header' do
        expect(@metadata.mobi_header).to be_a Mobi::Header::MobiHeader
      end

      it 'instantiates a exth_header' do
        expect(@metadata.exth_header).to be_a Mobi::Header::ExthHeader
      end
    end
  end

  context 'instance' do
    before :all do
      @metadata = Mobi::Metadata.new(@file)
    end

    it 'gets the the title of the book' do
      expect(@metadata.title).to eq('His Last Bow')
    end

    it 'is a bookmobi' do
      expect(@metadata.bookmobi?).to be true
    end

    it 'defines delgate exth record method names to the exth record' do
      mock.proxy(@metadata.exth_header).author

      expect(@metadata.author).to eq('Sir Arthur Conan Doyle')
    end
  end

end
