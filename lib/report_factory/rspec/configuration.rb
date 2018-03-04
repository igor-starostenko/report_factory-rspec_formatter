# frozen_string_literal: true

module ReportFactory
  module Rspec
    # Defines all configurable attributes of ReportFactory::RSpec
    module Configuration
      VALID_CONFIG_KEYS = %i[url project_name tags auth_token].freeze

      DEFAULT_URL = 'http://0.0.0.0:3000'

      DEFAULT_PROJECT_NAME = nil

      DEFAULT_AUTH_TOKEN = nil

      DEFAULT_TAGS = []

      VALID_CONFIG_KEYS.each { |key| attr_accessor key }

      # Make sure the default values are set when the module is 'extended'
      def self.extended(base)
        base.reset
      end

      def configure
        yield self
      end

      def reset
        VALID_CONFIG_KEYS.each do |key|
          constant_name = "DEFAULT_#{key}".upcase
          send("#{key}=", self::Configuration.const_get(constant_name))
        end
      end
    end
  end
end
