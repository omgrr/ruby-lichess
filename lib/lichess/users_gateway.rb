module Lichess
  class UsersGateway
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def all_top_ten
      path = "/player"
      @client.get(path)
    end
  end
end
