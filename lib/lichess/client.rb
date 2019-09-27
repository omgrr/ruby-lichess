require "net/http"
require "http"
require "logger"

module Lichess
  class Client
    attr_reader :token
    attr_accessor :logger

    def initialize(token, logger: nil)
      @token = token
      @logger = logger || Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @http = HTTP.use(logging: {logger: @logger})
    end

    def users
      @users_gateway ||= UsersGateway.new(self)
    end

    def games
      @games_gateway ||= GamesGateway.new(self)
    end

    def get(path, http_headers: {})
      url = "#{base_url}#{path}"

      http_headers[:accept] ||= "application/vnd.lichess.v3+json"
      http_headers[:content_type] ||= "application/json"
      http_headers[:authorization] ||= "Bearer #{@token}"

      response = @http
        .headers(http_headers)
        .get(url)

      return response
    end

    def post(path, body: nil, http_headers: {})
      url = "#{base_url}#{path}"

      http_headers[:accept] ||= "application/vnd.lichess.v3+json"
      http_headers[:content_type] ||= "application/json"

      response = @http
        .headers(http_headers)
        .post(url, body: body)

      return response
    end

    private

    def base_url
      "https://lichess.org"
    end
  end
end
