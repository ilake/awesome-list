require "rails_helper"

describe RepositoriesController do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }

  describe "#index" do
    it "response is success" do
      sign_in user

      get root_path
      expect(response).to be_successful
    end
  end

  describe "#create" do
    it "redirects to expected path" do
      response = spy(data: spy(errors: {}, as_json: { "data" => { "repository" => { "foo" => "bar" } }}))
      allow(GitHub::Client).to receive(:query).and_return(response)

      post repositories_path, params: { repositories_create: { technology_name: "foo", category_name: "bar", repository_name: "baz/qux" } }

      expect(response).to redirect_to(root_path)
    end

    context "when there is any error" do
      it "renders new template" do
        post repositories_path, params: { repositories_create: { technology_name: "foo", category_name: "bar", repository_name: "baz" } }

        expect(response).to render_template(:new)
      end
    end
  end
end
