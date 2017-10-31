require 'test_helper'

describe UsersController do
  describe "index" do
    it "succeeds with many users" do
      # Assumption: there are many users in the DB
      login(users(:another))
      User.count.must_be :>, 0

      get users_path
      must_respond_with :success
    end

  end

  describe "show" do
    it "succeeds for an extant user" do
      login(users(:another))

      get user_path(User.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus user" do
      # User.last gives the user with the highest ID
      login(users(:another))

      bogus_user_id = User.last.id + 1
      get user_path(bogus_user_id)
      must_respond_with :not_found
    end
  end
end
