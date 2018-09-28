module Lichess
  class UsersGateway
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get(username)
      path = "/api/user/#{username}"
      @client.get(path)
    end

    def activity(username)
      path = "/api/user/#{username}/activity"
      @client.get(path)
    end

    def all_top_ten
      path = "/player"
      @client.get(path)
    end

    def leaderboard(variant, number_of_users = 10)
      path = "/player/top/#{number_of_users}/#{variant}"
      @client.get(path)
    end
  end
end
