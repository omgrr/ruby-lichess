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

    def get(path)
      uri = URI("#{base_url}#{path}")

      req = Net::HTTP::Get.new(uri)
      req["Accept"] = "application/vnd.lichess.v3+json"
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
