require 'airbrake'
require 'rails'

module SourceTrack
  class Railtie < ::Rails::Railtie
    rake_tasks do
      #require 'source_track/rails/rake_tasks'
    end

    config.after_initialize do
      SourceTrack.configure(true) do |config|
        config.logger           ||= ::Rails.logger
        config.environment      ||= ::Rails.env
        config.app_root         ||= ::Rails.root
      end

      ActiveSupport.on_load(:action_controller) do
        # Lazily load action_controller methods
        #
        require 'source_track/rails/controller_methods'
        include SourceTrack::Rails::ControllerMethods
      end
    end
  end
end