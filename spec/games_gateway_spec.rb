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

  describe "users_games" do
    it "exports a users games" do
      games_gateway.users_games("farnswurth") do |json|
        expect(json["id"]).to_not be_nil
      end
    end
  end
end
