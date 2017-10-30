require 'test_helper'

describe User do
  describe "relations" do
    it "has a list of votes" do
      user = users(:grace)
      user.must_respond_to :votes
      user.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it "has a list of ranked works" do
      user = users(:ada)
      user.must_respond_to :ranked_works
      user.ranked_works.each do |work|
        work.must_be_kind_of Work
      end
    end
  end

  describe "validations" do
    it "requires a username" do
      user = User.new
      user.valid?.must_equal false
      user.errors.messages.must_include :username
    end

  end
end
