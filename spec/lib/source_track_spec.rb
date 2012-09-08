require 'spec_helper'

describe SourceTrack do
  it "should initialize" do
    SourceTrack.parser.should_not be_nil
    SourceTrack.configuration.should_not be_nil
  end
end