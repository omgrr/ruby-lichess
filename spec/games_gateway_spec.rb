require "spec_helper"

RSpec.describe Lichess::GamesGateway do
  let(:games_gateway) {
    Lichess::GamesGateway.new(
      Lichess::Client.new(
        valid_token,
        logger: Logger.new(StringIO.new)
      )
    )
  }

  describe "#export" do
    it "returns the game in a json format" do
      game = games_gateway.export("jXmynzOb")

      expect(game["id"]).to eq("jXmynzOb")
      expect(game["status"]).to eq("resign")
    end
  end

  describe "#users_games" do
    it "exports a users games" do
      games_gateway.users_games("farnswurth") do |json|
        expect(json["id"]).to_not be_nil
      end

    end

    it "defaults to 10 games" do
      games = []

      games_gateway.users_games("farnswurth") do |json|
        games << json
      end

      expect(games.length).to eq(10)
    end

    it "can specify the length" do
      games = []

      games_gateway.users_games("farnswurth", num_games: 8) do |json|
        games << json
      end

      expect(games.length).to eq(8)
    end

    it "can request only ongoing games" do
      games = []

      games_gateway.users_games("farnswurth", ongoing: true) do |json|
        games << json
      end

      expect(games.length).to eq(10)
    end

    it "can specify the variant" do
      games = []

      options = {}
      options[:perf] = "correspondence"
      options[:ongoing] = "true"

      games_gateway.users_games("farnswurth", options) do |json|
        games << json
      end

      expect(games.length).to be > 0

      games.each do |game|
        expect(game["perf"]).to eq("correspondence")
      end
    end

    it "can specify games against someone" do
      games = []

      options = {}
      options[:vs] = "bigswifty"
      options[:ongoing] = "true"

      games_gateway.users_games("farnswurth", options) do |json|
        games << json
      end

      expect(games.length).to be > 0

      games.each do |game|
        players = []
        players << game["players"]["white"]
        players << game["players"]["black"]

        expect(players.detect{ |player| player["user"]["id"] == "bigswifty" } ).to_not be_nil

      end
    end

    it "throws an error if requesting more than 30 games" do
      expect do
        games_gateway.users_games("farnswurth", num_games: Lichess::GamesGateway::MAX_GAMES + 1)
      end.to raise_error(Lichess::Exception::TooManyGames)
    end

    it "rejects invalid parameters" do
      expect do
        games_gateway.users_games("jfredett", eris: "kallisti")
      end.to raise_error(Lichess::Exception::InvalidParameter)
    end
  end

  describe "#ongoing_games" do
    it "gets the current users ongoing games" do
      current_games = games_gateway.ongoing_games
      expect(current_games).to_not be_empty
    end
  end
end
