require "rails_helper"

describe TechnologiesController do
  context "when user logged inn" do
    login_user

    it "should have a current_user" do
      get :index

      expect(subject.current_user).to_not eq(nil)
      expect(assigns(:technologies)).not_to be_nil
    end
  end

  context "when user doesn't login in" do
    it "redirect to sign in page" do
      get :index

      expect(subject).to redirect_to(new_user_session_path)
    end
  end
end
