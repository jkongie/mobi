require 'spec_helper'

describe Mobi do
  it "should instantiate a Mobi::Metadata object" do
    file = File.open('spec/fixtures/test.mobi')
    Mobi.metadata(file).should be_an_instance_of(Mobi::Metadata)
  end
end