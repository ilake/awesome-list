require "rails_helper"

RSpec.describe Repositories::Create do
  let(:user) { FactoryBot.create(:user) }
  let(:technology_name) { "foo" }
  let(:category_name) { "bar" }
  let(:repository_name) { "baz/qux" }
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
      details = { "foo" => "bar" }
      response = spy(data: spy(errors: {}, as_json: { "data" => { "repository" => details }}))

      allow(GitHub::Client).to receive(:query).with(GitHub::RepositoryQuery, variables: { owner: "baz", name: "qux" }).and_return(response)
      expect {
        outcome
      }.to change {
        user.technologies.count
      }.by(1).and change {
        Category.where(name: category_name, technology: user.technologies.take).count
      }.by(1).and change {
        Repository.where(name: repository_name, category: Category.find_by(name: category_name, technology: user.technologies.take), details: details).count
      }.by(1)

      expect(GitHub::Client).to have_received(:query).with(GitHub::RepositoryQuery, variables: { owner: "baz", name: "qux" })
    end

    context "when repository create failed" do
      context "when repository name is empty" do
        let(:repository_name) { "" }

        it "doesn't create any record and returns expected error" do
          expect {
            outcome
          }.not_to change {
            user.technologies.count
          }

          expect(outcome.errors.details[:base]).to include(error: "Name can't be blank")
        end
      end

      context "when repository name is nil" do
        let(:repository_name) { "foo" }

        it "doesn't create any record and returns expected error" do
          error_message = "error_message"
          response = spy(errors: spy(messages: {data: [error_message]}), data: nil)

          allow(GitHub::Client).to receive(:query).with(GitHub::RepositoryQuery, variables: { owner: "foo", name: nil }).and_return(response)

          expect {
            outcome
          }.not_to change {
            user.technologies.count
          }

          expect(outcome.errors.details[:base]).to include(error: error_message)
        end
      end

      context "when repository is not found" do
        let(:repository_name) { "foo/bar" }

        it "doesn't create any record and returns expected error" do
          error_message = "error_message"
          response = spy(data: spy(errors: { repository: [error_message] }))

          allow(GitHub::Client).to receive(:query).with(GitHub::RepositoryQuery, variables: { owner: "foo", name: "bar" }).and_return(response)

          expect {
            outcome
          }.not_to change {
            user.technologies.count
          }

          expect(outcome.errors.details[:base]).to include(error: error_message)
        end
      end
    end
  end
end
