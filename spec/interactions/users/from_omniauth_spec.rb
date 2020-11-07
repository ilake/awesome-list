require "rails_helper"

RSpec.describe Users::FromOmniauth do
  let(:email) { Faker::Internet.email }
  let(:name) { Faker::Name.first_name }
  let(:uid) { SecureRandom.uuid }
  let(:args) do
    {
      auth: OmniAuth::AuthHash.new({
        provider: "github",
        uid: uid,
        info: {
          email: email,
          name: name
        }
      }),
    }
  end
  let(:outcome) { described_class.run!(args) }

  describe "#execute" do
    it "creates a user" do
      expect {
        outcome
      }.to change {
        User.count
      }.by(1)
    end

    context "when the existing_user came again" do
      let!(:existing_user) { FactoryBot.create(:user, provider: "github", uid: uid, email: email, name: name) }

      it "is valid and doesn't create another user" do
        expect {
          outcome
        }.not_to change {
          User.count
        }
      end
    end
  end
end
