require 'spec_helper'

require 'mobi'

describe Mobi do
  it "instantiates a Mobi::Metadata object" do
    file = File.open('spec/fixtures/sherlock.mobi')
    expect(Mobi.metadata(file)).to be_an_instance_of(Mobi::Metadata)
  end
end
