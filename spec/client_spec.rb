require "spec_helper"

RSpec.describe Lichess::Client do
  describe "#users" do
    it "returns a UsersGateway" do
      client = Lichess::Clien.new(valid_token)

      expect(client.users).to be_a(Lichess::UsersGateway)
    end
  end
end
