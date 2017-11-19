# frozen_string_literal: true

require 'net/http'

module ReportFactory
  module Rspec
    # An RSpec formatter that formats json from the test run
    class API
      def self.send_report(report_hash)
        payload = format_payload(report_hash)
        Net::HTTP.post_form(create_report_url, format_headers, payload)
      end

      private

      def format_headers
        { 'X-API-KEY' => x_api_key }
      end

      def format_payload(report_hash)
        {
          data: {
            type: 'rspec_report',
            attributes: report_hash
          }
        }
      end

      def x_api_key
        ReportFactory::Rspec::Configuration.auth_token
      end

      def base_url
        ReportFactory::Rspec::Configuration.url
      end

      def project_name
        ReportFactory::Rspec::Configuration.project_name
      end

      def create_report_url
        URI.parse("#{base_url}/api/v1/projects/#{project_name}/reports/rspec")
      end
    end
  end
end
