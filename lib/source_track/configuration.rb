require 'date'

module SourceTrack
  # Used to set up and modify settings for the notifier.
  class Configuration

    DEFAULT_SEPERATOR = "|"
    DEFAULT_EPOCH = Date.new(2012,1,1)
    OPTIONS = [:use_dates, :signed_cookies, :signing_secret, :seperator, :epoch, :logger].freeze

    # Add a date component to the source token stored
    attr_writer :use_dates

    # Use secure cookies (uses what comes with rails) or HMAC sign cookies
    attr_accessor :signed_cookies

    # Cookie Signing Secret
    attr_accessor :signing_secret

    # Seperator (can't be 0-9 A-F or other undesireables in cookies)
    attr_writer :seperator

    # Cookie Name
    attr_accessor :cookie_name

    # Epoch date to use for hexdates
    attr_accessor :epoch

    # Length of hexdate
    attr_accessor :date_length

    attr_accessor :logger
    
    def initialize
      @epoch = DEFAULT_EPOCH
      @date_length = 4
      @cookie_name = "sct"
    end

    # Default true
    def use_dates
      @use_dates || true
    end
    alias_method :use_dates?, :use_dates

    def seperator
      @seperator || DEFAULT_SEPERATOR
    end

    #alias_method :signed_cookies?, :signed_cookies

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