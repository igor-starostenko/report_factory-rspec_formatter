# frozen_string_literal: true

require 'report_factory/rspec/configuration'
require 'report_factory/rspec/version'

module ReportFactory
  # Top level namespace module
  module Rspec
    extend Configuration
    # TODO: Add method missing
  end
end

require 'report_factory/rspec/formatter'
