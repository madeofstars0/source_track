require 'spec_helper'

describe SourceTrack::TokenParser do

  context "with use_dates" do
    before(:each) do 
      @parser = SourceTrack.parser
    end

    it "should encode a single token value" do
      @parser.encode({:token => "ABC", :date => Date.new(2012,9,7)}).should eq "ABC00FA"
    end

    it "should encode an array of tokens" do
      @parser.encode([
        {:token => "BBC", :date => Date.new(2012,9,7)}, 
        {:token => "WOWZA9828", :date => Date.new(2012,10,9)}
        ]).should eq "BBC00FA|WOWZA9828011A"
    end
  end

  context "without use_dates" do
    before(:each) do 
      @parser = SourceTrack.parser
    end

    it "encode a single token value" do
      @parser.encode({:token => "ABC"}).should eq "ABC"
    end

    it "should encode an array of tokens" do
      @parser.encode([
        {:token => "39828ABO"}, {:token => "HOLF392"}
        ]).should eq "39828ABO|HOLF392"
    end

    it "should encode an array of tokens" do
      # @parser.encode([
      #   {:token => "39828ABO", :date => Date.new(2012,9,7)}, 
      #   {:token => "HOLF392", :date => Date.new(2012,10,9)}
      #   ]).should eq "39828ABO|HOLF392"
    end
  end
end