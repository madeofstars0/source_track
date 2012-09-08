require 'spec_helper'

describe SourceTrack::Configuration do
  let(:config) { SourceTrack.configuration }

  it "should initialize with the defaults" do
    config.use_dates.should         be_true
    config.separator.should         eq '|'
    config.epoch.should             eq Date.new(2012,1,1)
    config.date_length.should       eq 4
    config.cookie_name.should       eq 'sct'
    config.http_only_cookies.should be_true
    config.cookie_path.should       eq '/'
  end
end