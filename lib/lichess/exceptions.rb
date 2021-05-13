module Lichess
  module Exception
    class UserNotFound < StandardError; end
    class TooManyGames < StandardError; end
    class InvalidParameter < StandardError; end
  end
end

