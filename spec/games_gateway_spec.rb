require "spec_helper"

RSpec.describe Lichess::GamesGateway do
  let(:games_gateway) { Lichess::GamesGateway.new(Lichess::Client.new(valid_token)) }

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

    it "throws an error if requesting more than 30 games" do
      expect do
        games_gateway.users_games("farnswurth", num_games: Lichess::GamesGateway::MAX_GAMES + 1)
      end.to raise_error(Lichess::Exception::TooManyGames)
    end
  end
end
