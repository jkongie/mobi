require 'spec_helper'

require 'mobi'

describe Mobi do
  it "should instantiate a Mobi::Metadata object" do
    file = File.open('spec/fixtures/sherlock.mobi')
    Mobi.metadata(file).should be_an_instance_of(Mobi::Metadata)
  end
end