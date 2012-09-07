module SourceTrack
  module Rails
    module ControllerMethods

      # TODO: It would be nice on page load (or before filter) to load an array of tokens accessible
      #  inside the controller (maybe with extra methods like has_token?)
      #  it would get parsed at the start of the request cycle (in the controller), any modifications would be
      #  stored in an instance variable (i.e. track, clear, etc), state of dirty? would become true, then
      #  when response is being generated, set the cookie if dirty? is true

      # it would look similar to this (we would send a cookie with A9212 source token with today's date)
      # before_filter :scene_track
      # def show
      #   track_source("A9212")
      # end
      #
      # def signup
      #   @user.sources = source_tokens
      #   @user.super_important_person = true if source_tokens.has_source("VIP")  (should we also be able to filter by date?)
      #   @user.save!
      #   source_tokens.clear
      #   redirect root_url
      # end

      # TODO - make sure the cookie is a far future expires
      def track_source(token, options = {})
        tokens = SourceTrack.parser.parse(cookies[SourceTrack.configuration.cookie_name]) 
        tokens << {:token => token, :date => Date.today}
        cookies[SourceTrack.configuration.cookie_name] = SourceTrack.parser.encode(tokens)
      end

      # TODO - make sure the instance variables are on an instance, not the class
      def source_tokens
        @tokens ||= SourceTrack.parser.parse(cookies[SourceTrack.configuration.cookie_name])
      end

      def clear_tokens
        cookies.delete SourceTrack.configuration.cookie_name
      end

      def has_source(token)
        source_tokens.map{|m| m[:token]}.include?(token)
      end
      alias_method :has_source?, :has_source

    end
  end
end