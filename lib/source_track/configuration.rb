require 'date'

module SourceTrack
  # Used to set up and modify settings for the notifier.
  class Configuration

    DEFAULT_SEPARATOR = "|"
    DEFAULT_EPOCH = Date.new(2012,1,1)
    DEFAULT_DATE_LENGTH = 4
    OPTIONS = [:use_dates, :separator, :epoch, :date_length, :cookie_name, :http_only_cookies,
               :cookie_path, :environment, :app_root, :logger].freeze

    # Add a date component to the source token stored
    attr_writer :use_dates

    # Separator (can't be 0-9 A-F or other undesireables in cookies), default to pipe (|)
    attr_writer :separator
    

    # Epoch date to use for hexdates
    attr_accessor :epoch

    # Length of hexdate (defaults to 4)
    attr_accessor :date_length

    # HTTP cookies
    attr_accessor :cookie_name
    attr_accessor :http_only_cookies
    attr_accessor :cookie_path

    # Application specifics
    attr_accessor :environment
    attr_accessor :app_root
    attr_accessor :logger
    
    def initialize
      @epoch = DEFAULT_EPOCH
      @date_length = DEFAULT_DATE_LENGTH
      @cookie_name = 'sct'
      @http_only_cookies = true
      @cookie_path = '/'
    end

    # Track data along with the source token
    def use_dates
      @use_dates || true
    end
    alias_method :use_dates?, :use_dates

    def separator
      @separator || DEFAULT_SEPARATOR
    end

    # Allows config options to be read like a hash
    #
    # @param [Symbol] option Key for a given attribute
    def [](option)
      send(option)
    end

    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash[option.to_sym] = self.send(option)
        hash
      end
    end

    # Returns a hash of all configurable options merged with +hash+
    #
    # @param [Hash] hash A set of configuration options that will take precedence over the defaults
    def merge(hash)
      to_hash.merge(hash)
    end
  end
end