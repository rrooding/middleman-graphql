require 'middleman-core'
require 'middleman-graphql/extension'
require 'middleman-graphql/commands/graphql'

Middleman::Extensions.register(:graphql, MiddlemanGraphql::Extension)
