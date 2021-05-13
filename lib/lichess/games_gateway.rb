require "ndjson"

module Lichess
  class GamesGateway
    attr_reader :client

    MAX_GAMES = 30

    VALID_PARAMS = {
      users_games: %w{perf perfType since until max vs rated color analysed ongoing movies pgnInJson tags clocks evals opening players ongoing, num_games}.map(&:to_sym)
    }

    def initialize(client)
      @client = client
    end

    def export(game_id)
      path = "/game/export/#{game_id}"

      http_headers = {}
      http_headers[:accept] = "application/json"
      http_headers[:content_type] = "application/json"

      result = @client.get(path, http_headers: http_headers)
      JSON.parse(result.body)
    end


    def users_games(user_id, options = {}, &blk)
      num_games = options[:num_games] || 10

      if num_games > MAX_GAMES
        raise Exception::TooManyGames.new("Cannot request more than 30 games")
      end

      invalid_params = options.keys.reject { |k| VALID_PARAMS[:users_games].include? k }
      raise Exception::InvalidParameter.new("#{invalid_params.join(",")} parameters were supplied, but are invalid") if invalid_params.any?

      path = "/api/games/user/#{user_id}?max=#{num_games}"

      # kept to keep backward compat
      path << "&perfType=#{options[:perf]}" if options[:perf]

      options.each do |key, value|
        path << "&#{key}=#{value}"
      end

      result = @client.get(path, http_headers: ndjson_headers)
      stringio = StringIO.new(result.body)

      NDJSON::Parser.new(stringio).each do |json|
        yield json
      end
    end

    def ongoing_games
      path = "/api/account/playing"

      result = @client.get(path)

      JSON.parse(result.body)
    end

    private

    def ndjson_headers
      http_headers = {}
      http_headers[:accept] = "application/x-ndjson"
      http_headers[:content_type] = "application/x-ndjson"

      http_headers
    end
  end
end
