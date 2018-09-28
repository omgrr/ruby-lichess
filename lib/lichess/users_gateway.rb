require "json"

module Lichess
  class UsersGateway
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get(username)
      path = "/api/user/#{username}"
      result = @client.get(path)

      if result.code == "404"
        raise Lichess::Exception::UserNotFound.new("#{username} not found")
      end

      JSON.parse(result.body)
    end

    def activity(username)
      path = "/api/user/#{username}/activity"
      JSON.parse(@client.get(path).body)
    end

    def all_top_ten
      path = "/player"
      JSON.parse(@client.get(path).body)
    end

    def leaderboard(variant, number_of_users = 10)
      path = "/player/top/#{number_of_users}/#{variant}"
      JSON.parse(@client.get(path).body)
    end
  end
end
