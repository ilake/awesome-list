require "graphql/client"
require "graphql/client/http"

module GitHub
  API_URL = "https://api.github.com/graphql".freeze

  HTTPAdapter = GraphQL::Client::HTTP.new(API_URL) do
    def headers(_)
      {
        "Authorization" => "Bearer #{Rails.application.credentials.github[:access_token]}"
      }
    end
  end

  Schema = GraphQL::Client.load_schema(HTTPAdapter)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTPAdapter)
end
