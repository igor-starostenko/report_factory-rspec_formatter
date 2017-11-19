# frozen_string_literal: true

module ReportFactory
  module RSpec
    # Defines all configurable attributes of ReportFactory::RSpec
    module Configuration
      VALID_CONFIG_KEYS = %i[url x_api_key].freeze

      DEFAULT_URL = 'http://0.0.0.0:3000'

      DEFAULT_X_API_KEY = nil

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
          send("#{key}=", Object.const_get("DEFAULT_#{key}".upcase))
        end
      end
    end
  end
end