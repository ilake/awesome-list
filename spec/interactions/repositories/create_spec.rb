require "rails_helper"

RSpec.describe Repositories::Create do
  let(:user) { FactoryBot.create(:user) }
  let(:technology_name) { "foo" }
  let(:category_name) { "bar" }
  let(:repository_name) { "baz" }
  let(:args) do
    {
      user: user,
      technology_name: technology_name,
      category_name: category_name,
      repository_name: repository_name
    }
  end
  let(:outcome) { described_class.run(args)  }

  describe "#execute" do
    it "created expected records" do
      expect {
        outcome
      }.to change {
        user.technologies.count
      }.by(1).and change {
        Category.where(name: category_name, technology: user.technologies.take).count
      }.by(1).and change {
        Repository.where(name: repository_name, category: Category.find_by(name: category_name, technology: user.technologies.take)).count
      }.by(1)
    end

    context "when repository create failed" do
      let(:repository_name) { "" }

      it "doesn't create any record and return errors" do
        expect {
          outcome
        }.not_to change {
          user.technologies.count
        }

        expect(outcome.errors.details[:base]).to include(error: "Name can't be blank")
      end
    end
  end
end
