require 'middleman-cli'
require 'graphlient'

module Middleman
  module Cli
    class Graphql < Thor::Group
      include Thor::Actions

      check_unknown_options!

      def graphql
        unless extension.options[:enabled]
          puts "== GraphQL queries disabled in config.rb (graphql.enabled = false)"
          exit
        end

        raise Thor::Error.new "You need to activate the graphql extension in config.rb before you can import data" if extension.nil?

        query_files.each do |filename|
          query(filename)
        end

        puts "== GraphQL import: Done"
      end

      def self.exit_on_failure?
        true
      end

      private

      def client
        @client ||= Graphlient::Client.new(extension.options[:endpoint],
                                           headers: headers)
      end

      def headers
        headers = {}

        headers[:authorization] = "Token #{extension.options[:token]}" if extension.options[:token]
        headers
      end

      def query(filename)
        print "== Running query #{File.basename(filename)}"
        request = File.read(filename)
        result = client.query(request)
        raise "No data retreived" unless result.data
        write_result(File.basename(filename, '.graphql'), result)
      rescue Graphlient::Errors::ServerError, NoMethodError => e
        # We need to catch NoMethodError here because of a bug in Graphlient
        # url: https://github.com/ashkan18/graphlient/issues/51

        puts "\n== Error connecting to the API (#{extension.options[:endpoint]}): #{e.message}"
        exit 1
      end

      def write_result(target, data)
        filename = target + '.yml'
        puts "== => #{filename}"
        File.open(app.root_path.join('data', filename), 'w') do |f|
          f.write data.original_hash['data'].to_yaml
        end
      end

      def queries_dir
        app.root_path.join('queries')
      end

      def query_files
        Dir.glob(queries_dir.join('*.graphql'))
      end

      def app
        @app ||= ::Middleman::Application.new do
          config[:mode] = :graphql
        end
      end

      def extension
        @extension = app.extensions[:graphql]
      end

      Base.register(self, 'graphql', 'graphql', 'Import GraphQL data to your Data folder')
    end
  end
end
