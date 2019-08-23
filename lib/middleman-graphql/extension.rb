require "middleman-graphql/version"

module MiddlemanGraphql
  class Extension < ::Middleman::Extension
    option :endpoint, nil, 'The GraphQL endpoint to use'
    option :token, nil, 'The authentication token to use'
  end
end
