require 'spec_helper'

require 'mobi/stream_slicer'

describe Mobi::StreamSlicer do
  let(:file){ File.open('spec/fixtures/sherlock.mobi') }

  context "instantiation" do
    it "should set the start point to 0 if no start is provided" do
      ss = Mobi::StreamSlicer.new(file)
      ss.start.should == 0
    end

    it "should set the end point to the file end if no stop is provided" do
      ss = Mobi::StreamSlicer.new(file)
      ss.stop.should == 111449
    end

    it "should set the start and stop points to the arguments provided" do
      ss = Mobi::StreamSlicer.new(file, 1, 2)
      ss.start.should == 1
      ss.stop.should == 2
    end

    it "should set the length" do
      ss = Mobi::StreamSlicer.new(file, 1, 10)
      ss.length.should == 9
    end

    it "should set the stream to the input file" do
      ss = Mobi::StreamSlicer.new(file)
      ss.stream.should == file
    end
  end

  context "#[]" do

    it "should return 1 byte" do
      ss = Mobi::StreamSlicer.new(file)
      ss[0].length.should == 1
    end

    it "should start the search from the offset provided" do
      file.seek(5)
      value = file.read(1)
      ss = Mobi::StreamSlicer.new(file, 5)
      ss[0].should == value
    end

    it "should return the correct number of bytes" do
      file.seek(5)
      value = file.read(2)
      ss = Mobi::StreamSlicer.new(file, 5)
      ss[0, 2].should == value
    end

    it "should seek in reverse order" do
      file.seek(8)
      value = file.read(2)
      ss = Mobi::StreamSlicer.new(file, 5)
      ss[5, -2].should == value
    end
  end
end
