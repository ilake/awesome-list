require "rails_helper"

describe TechnologiesController do
  let(:user) { FactoryBot.create(:user) }

  describe "#index" do
    it "response is success" do
      sign_in user

      get root_path
      expect(response).to be_successful
    end

    context "when user doesn't sign in" do
      it "response is success" do
        get root_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
