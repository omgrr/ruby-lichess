require "spec_helper"

RSpec.describe Lichess::UsersGateway do
  let(:users_gateway) {
    Lichess::UsersGateway.new(
      Lichess::Client.new(
        valid_token,
        logger: Logger.new(StringIO.new),
      )
    )
  }

  describe "#get" do
    it "returns the users public data" do
      user = users_gateway.get("farnswurth")

      expect(user["id"]).to eq("farnswurth")
    end

    it "raises an exception if the user is not found" do
      expect do
        users_gateway.get("a_user_that_does_not_exist_probably")
      end.to raise_error(Lichess::Exception::UserNotFound)
    end
  end

  describe "#activity" do
    it "returns the users recent activity" do
      activity = users_gateway.activity("farnswurth")

      expect(activity.length).to_not be(0)
    end

    it "raises an exception if the user is not found" do
      expect do
        users_gateway.activity("a_user_that_does_not_exist_probably")
      end.to raise_error(Lichess::Exception::UserNotFound)
    end
  end

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

  describe "#leaderboard" do
    it "returns the leaderboard of the requests variant" do
      leaderboard = users_gateway.leaderboard("blitz")

      expect(leaderboard["users"]).to_not be_empty
    end

    it "defaults to 10 users" do
      leaderboard = users_gateway.leaderboard("blitz")

      expect(leaderboard["users"].length).to eq(10)
    end

    it "accepts a custom number of users" do
      leaderboard = users_gateway.leaderboard("blitz", 100)

      expect(leaderboard["users"].length).to eq(100)
    end
  end
end
