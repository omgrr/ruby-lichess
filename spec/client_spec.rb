require "spec_helper"

RSpec.describe Lichess::Client do
  let(:client) {
    Lichess::Client.new(valid_token, logger: StringIO.new)
  }

  describe "#users" do
    it "returns a UsersGateway" do
      expect(client.users).to be_a(Lichess::UsersGateway)
    end
  end

  describe "#games" do
    it "returns a GamesGateway" do
      expect(client.games).to be_a(Lichess::GamesGateway)
    end
  end

  describe "#get" do
    it "Logs the request" do
      log_output = StringIO.new
      client = Lichess::Client.new(valid_token, logger: log_output)

      client.get("/api/user/omgrr")

      expect(log_output.string).to match(/GET https:\/\/lichess.org\/api\/user\/omgrr/)
    end
  end
end
