require 'source_track/version'
require 'source_track/configuration'
require 'source_track/token_parser'

require 'source_track/railtie' if defined?(Rails::Railtie)

module SourceTrack
  class << self

    # Configuration object. Must act like a hash and return sensible
    # values for all configuration options.
    attr_writer :configuration

    # Call this method to modify defaults in your initializers.
    #
    # @example
    #   SourceTrack.configure do |config|
    #     config.use_dates      = true
    #     config.signed_cookies = false
    #   end
    def configure(silent = false)
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def parser
      @parser ||= TokenParser.new
    end

  end
end
