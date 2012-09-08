require 'date'
require 'open-uri'

module SourceTrack
  class TokenParser

    def initialize
      @config = SourceTrack.configuration
    end

    # Take the string from the cookie and return the source tokens (token and optional date)
    # ABC12300FA|CODE2300FB|CD2380    #( with dates, last 4 characters are hex )
    # ABBC123|CODE23|CD       #( no dates )
    # we MUST preserve order
    def parse(v)
      return [] if v.nil? || v.strip.empty?

      tokens = []
      v.split(@config.separator).each do |t|
        # validate the token is valid

        if @config.use_dates?
          token, token_date = split_token_date(t, @config.date_length)
          tokens << {:token => token, :date => get_date(token_date, @config.epoch)}
        else
          tokens << {:token => t}
        end
        
      end

      tokens
    end

    # returns a string that can be set in the cookie
    # we may or may not need to encode so the cookies work in all situations
    def encode(tokens)
      return nil if tokens.nil?
      tokens = [tokens] unless tokens.is_a?(Array)

      # TODO: tokens need to be unique (duplicates need to remain at the end), remember
      #       the order from left to right is oldest to newest - any duplicates should always be newest
      #       (i.e. if we 'track' a user using the same token on the same day 2x - the second visit's position
      #       should be meaningful) -- i.e.  order of tracking => A, F, B, F, C  should encode as A|B|F|C, NOT A|F|B|C
      tokens.map{|t| encode_token(t) }.join(@config.separator)
    end

    private

    def encode_token(token)
      encoded_token = token[:token]
      encoded_token += get_hex_date(token[:date], @config.epoch) unless token[:date].nil?
      encoded_token
    end

    def split_token_date(v, n)
      # validate token
      date_part = v[-n,n]
      tok_part = v[0..(-n - 1)]
      [tok_part, date_part]
    end

    def get_date(hex_date, epoch)
      # validate hex_date
      epoch + hex_date.hex
    end

    def get_hex_date(date, epoch)
      sprintf("%04X", (date - epoch))
    end
  end
end