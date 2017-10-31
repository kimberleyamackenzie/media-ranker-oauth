require "test_helper"

describe SessionsController do
  describe "login_form" do
    # The login form is a static page - no real way to make it fail
    it "succeeds" do
      login(users(:ada))
      must_respond_with :redirect
      must_redirect_to root_path

      session[:user_id].must_equal users(:ada).id
    end
  end

  describe "login" do
    # This functionality is complex!
    # There are definitely interesting cases I haven't covered
    # here, but these are the cases I could think of that are
    # likely to occur. More test cases will be added as bugs
    # are uncovered.
    #
    # Note also: some more behavior is covered in the upvote tests
    # under the works controller, since that's the only place
    # where there's an interesting difference between a logged-in
    # and not-logged-in user.
    # it "succeeds for a new user" do
    #   username = "test_user"
    #   # Precondition: no user with this username exists
    #   User.find_by(username: username).must_be_nil
    #
    #   post login_path, params: { username: username }
    #   must_redirect_to root_path
    # end

    # it "succeeds for a returning user" do
    #   login(users(:grace))
    #   must_redirect_to root_path
    # end
    #
    # it "succeeds if a different user is already logged in" do
    #   login(users(:ada))
    #   must_redirect_to root_path
    #
    #   login(users(:grace))
    #   must_redirect_to root_path
    # end
  end

  describe "logout" do
    it "succeeds if the user is logged in" do
      # Gotta be logged in first
      login(users(:ada))
      must_redirect_to root_path

      post logout_path
      must_redirect_to root_path
    end

    it "succeeds if the user is not logged in" do
      post logout_path
      must_redirect_to root_path
    end
  end
end
