require "spec_helper"

RSpec.describe Lichess::UsersGateway do
  let(:users_gateway) { Lichess::UsersGateway.new(Lichess::Client.new(valid_token)) }

  describe "#all_top_ten" do
    it "returns the top ten of all the different types of games" do
      top_ten = users_gateway.all_top_ten

      expect(top_ten["antichess"]).to_not be_empty
      expect(top_ten["atomic"]).to_not be_empty
      expect(top_ten["blitz"]).to_not be_empty
      expect(top_ten["bullet"]).to_not be_empty
      expect(top_ten["chess960"]).to_not be_empty
      expect(top_ten["classical"]).to_not be_empty
      expect(top_ten["crazyhouse"]).to_not be_empty
      expect(top_ten["horde"]).to_not be_empty
      expect(top_ten["kingOfTheHill"]).to_not be_empty
      expect(top_ten["racingKings"]).to_not be_empty
      expect(top_ten["rapid"]).to_not be_empty
      expect(top_ten["threeCheck"]).to_not be_empty
      expect(top_ten["ultraBullet"]).to_not be_empty
    end
  end
end
