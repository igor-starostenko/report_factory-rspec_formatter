# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'

module ReportFactory
  module Rspec
    # An RSpec formatter that formats json from the test run
    class API
      def self.send_report(report_hash)
        uri = create_report_url
        request = Net::HTTP::Post.new(uri.request_uri, format_headers)
        request.body = format_payload(report_hash).to_json
        net_http = Net::HTTP.new(uri.host, uri.port)
        net_http.use_ssl = true if uri.scheme == 'https'
        net_http.request(request)
      end

      def self.format_headers
        {
          'Content-Type': 'application/json',
          'X-API-KEY' => x_api_key
        }
      end

      def self.format_payload(report_hash)
        attributes = {tags: tags}.merge(report_hash)
        {
          data: {
            type: 'rspec_report',
            attributes: attributes
          }
        }
      end

      def self.x_api_key
        ReportFactory::Rspec.auth_token
      end

      def self.base_url
        ReportFactory::Rspec.url
      end

      def self.project_name
        ReportFactory::Rspec.project_name
      end

      def self.tags
        ReportFactory::Rspec.tags
      end

      def self.create_report_url
        URI.parse("#{base_url}/api/v1/projects/#{project_name}/reports/rspec")
      end
    end
  end
end
