require "middleman-graphql/version"

module MiddlemanGraphql
  class Extension < ::Middleman::Extension
    option :enabled, false, 'Should we run queries or not'
    option :endpoint, nil, 'The GraphQL endpoint to use'
    option :token, nil, 'The authentication token to use'
  end
end
