require "spec_helper"

RSpec.describe Lichess::Client do
  describe "#users" do
    it "returns a UsersGateway" do
      client = Lichess::Client.new(valid_token)

      expect(client.users).to be_a(Lichess::UsersGateway)
    end
  end

  describe "#games" do
    it "returns a GamesGateway" do
      client = Lichess::Client.new(valid_token)

      expect(client.games).to be_a(Lichess::GamesGateway)
    end
  end
end
