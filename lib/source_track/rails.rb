require 'source_track'
require 'source_track/rails/controller_methods'

module SourceTrack
  module Rails

    def self.initialize
      if defined?(ActionController::Base)
        ActionController::Base.send(:include, SourceTrack::Rails::ControllerMethods)
      end

      track_logger = if defined?(::Rails.logger)
                       ::Rails.logger
                     elsif defined?(RAILS_DEFAULT_LOGGER)
                       RAILS_DEFAULT_LOGGER
                     end

      SourceTrack.configure(true) do |config|
        config.logger = track_logger
      end
    end

  end
end

SourceTrack::Rails.initialize