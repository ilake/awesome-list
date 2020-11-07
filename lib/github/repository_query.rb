module GitHub
  RepositoryQuery = Client.parse <<-'GRAPHQL'
    query($owner: String!, $name: String!){
      repository(owner: $owner, name: $name) {
        url
        description
        stargazerCount
        forkCount
        updatedAt
      }
    }
  GRAPHQL
end
