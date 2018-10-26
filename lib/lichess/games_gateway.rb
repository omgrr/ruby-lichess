require "ndjson"

module Lichess
  class GamesGateway
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def export(game_id)
      path = "/game/export/#{game_id}"

      http_headers = {}
      http_headers[:accept] = "application/json"
      http_headers[:content_type] = "application/json"

      result = @client.get(path, http_headers)
      JSON.parse(result.body)
    end

    def users_games(user_id, num_games: 10, &blk)
      path = "/api/games/user/#{user_id}?max=#{num_games}"

      http_headers = {}
      http_headers[:accept] = "application/x-ndjson"
      http_headers[:content_type] = "application/x-ndjson"

      result = @client.get(path, http_headers)
      stringio = StringIO.new(result.body)

      NDJSON::Parser.new(stringio).each do |json|
        yield json
      end
    end
  end
end
