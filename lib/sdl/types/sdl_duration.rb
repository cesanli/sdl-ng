require 'active_support/duration'

module SDL
  module Types
    class SDLDuration < SDLSimpleType
      include SDLType

      wraps ActiveSupport::Duration
      codes :duration
    end
  end
end