require "net/http"

module Lichess
  class Client
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def users
      @users_gateway ||= UsersGateway.new(self)
    end

    def games
      @games_gateway ||= GamesGateway.new(self)
    end

    def get(path, http_headers = {})
      uri = URI("#{base_url}#{path}")

      req = Net::HTTP::Get.new(uri)
      req["Accept"] = http_headers[:accept] || "application/vnd.lichess.v3+json"
      req["Content-Type"] = http_headers[:content_type] || "application/json"

      result = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
      end

      return result
    end

    private

    def base_url
      "https://lichess.org"
    end
  end
end
