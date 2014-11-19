require 'spec_helper'

require 'mobi/stream_slicer'

describe Mobi::StreamSlicer do
  let(:file){ File.open('spec/fixtures/sherlock.mobi') }

  context "instantiation" do
    it "sets the start point to 0 if no start is provided" do
      ss = Mobi::StreamSlicer.new(file)
      expect(ss.start).to eq(0)
    end

    it "sets the end point to the file end if no stop is provided" do
      ss = Mobi::StreamSlicer.new(file)
      expect(ss.stop).to eq(111449)
    end

    it "sets the start and stop points to the arguments provided" do
      ss = Mobi::StreamSlicer.new(file, 1, 2)
      expect(ss.start).to eq(1)
      expect(ss.stop).to eq(2)
    end

    it "sets the length" do
      ss = Mobi::StreamSlicer.new(file, 1, 10)
      expect(ss.length).to eq(9)
    end

    it "sets the stream to the input file" do
      ss = Mobi::StreamSlicer.new(file)
      expect(ss.stream).to eq(file)
    end
  end

  context "#[]" do

    it "returns 1 byte" do
      ss = Mobi::StreamSlicer.new(file)
      expect(ss[0].length).to eq(1)
    end

    it "starts the search from the offset provided" do
      file.seek(5)
      value = file.read(1)
      ss = Mobi::StreamSlicer.new(file, 5)
      expect(ss[0]).to eq(value)
    end

    it "returns the correct number of bytes" do
      file.seek(5)
      value = file.read(2)
      ss = Mobi::StreamSlicer.new(file, 5)
      expect(ss[0, 2]).to eq(value)
    end

    it "seeks in reverse order" do
      file.seek(8)
      value = file.read(2)
      ss = Mobi::StreamSlicer.new(file, 5)
      expect(ss[5, -2]).to eq(value)
    end
  end
end
