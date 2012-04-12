require 'spec_helper'

describe Mobi::Metadata do

  context 'initialization' do
    let(:file){ File.open('spec/fixtures/test.mobi') }

    it 'should assign the stream' do
      metadata = Mobi::Metadata.new(file)

      metadata.stream.should == file
    end

    it 'should instantiate a StreamSlicer from the file' do
      metadata = Mobi::Metadata.new(file)

      metadata.data.should be_instance_of(Mobi::StreamSlicer)
      metadata.data.stream.should == file
    end

    it 'should return nil if the book is not a mobi' do
      any_instance_of(Mobi::Metadata) do |m|
        mock(m).bookmobi? { false }
      end

      lambda{ Mobi::Metadata.new(file) }.should raise_exception(Mobi::Metadata::InvalidMobi)
    end
  end

end
