require "rails_helper"

describe Users::SessionsController do
  let(:user) { FactoryBot.create(:user) }

  context "when user logged in" do
    it "redirect to root page" do
      sign_in user

      get new_user_session_path

      expect(response).to redirect_to(root_path)
    end
  end
end
