# frozen_string_literal: true

require 'json'
require 'report_factory/rspec/api'
require 'rspec/core'
require 'rspec/core/formatters/base_formatter'

module ReportFactory
  module Rspec
    # An RSpec formatter that formats json from the test run
    class Formatter < RSpec::Core::Formatters::BaseFormatter
      RSpec::Core::Formatters.register self, :message, :dump_summary,
           :dump_profile, :stop, :seed, :close

      attr_reader :output_hash

      def initialize(output)
        super
        @output_hash = {
          version: RSpec::Core::Version::STRING
        }
      end

      def message(notification)
        (@output_hash[:messages] ||= []) << notification.message
      end

      def dump_summary(summary)
        errors_outside_count = summary.errors_outside_of_examples_count
        @output_hash[:summary] = {
          duration: summary.duration,
          example_count: summary.example_count,
          failure_count: summary.failure_count,
          pending_count: summary.pending_count,
          errors_outside_of_examples_count: errors_outside_count
        }
        @output_hash[:summary_line] = summary.totals_line
      end

      def stop(notification)
        @output_hash[:examples] = notification.examples.map do |example|
          format_example(example).tap do |hash|
            hash[:exception] = format_exception(example)
          end
        end
      end

      def seed(notification)
        return unless notification.seed_used?
        @output_hash[:seed] = notification.seed
      end

      def close(_notification)
        return if @output_hash[:examples].empty?
        print_result(ReportFactory::Rspec::API.send_report(@output_hash))
      end

      def dump_profile(profile)
        @output_hash[:profile] = {}
        dump_profile_slowest_examples(profile)
        dump_profile_slowest_example_groups(profile)
      end

      # @api private
      def dump_profile_slowest_examples(profile)
        @output_hash[:profile] = {}
        @output_hash[:profile][:examples] = format_profile_examples(profile)
        @output_hash[:profile][:slowest] = profile.slow_duration
        @output_hash[:profile][:total] = profile.duration
      end

      # @api private
      def dump_profile_slowest_example_groups(profile)
        @output_hash[:profile] ||= {}
        @output_hash[:profile][:groups] = format_profile_groups(profile)
      end

      private

      def print_result(response)
        return print_success if response.code == '201'
        print_error(response)
      end

      def print_success
        output.write "Report was successfullty submitted to ReportFactory\n"
      end

      def print_error(response)
        output.write 'Unfortunately the test report could not be submitted'\
                     " to ReportFactory. #{response.code}: #{response.msg}\n"
      end

      def format_example(example)
        {
          id: example.id,
          description: example.description,
          full_description: example.full_description,
          status: example.execution_result.status.to_s,
          file_path: example.metadata[:file_path],
          line_number: example.metadata[:line_number],
          run_time: example.execution_result.run_time,
          pending_message: example.execution_result.pending_message
        }
      end

      def format_exception(example)
        exception = example.exception
        return unless exception
        {
          class: exception.class.name,
          message: exception.message,
          backtrace: exception.backtrace
        }
      end

      def format_profile_examples(profile)
        profile.slowest_examples.map do |example|
          format_example(example).tap do |hash|
            hash[:run_time] = example.execution_result.run_time
          end
        end
      end

      def format_profile_groups(profile)
        profile.slowest_groups.map { |loc, hash| hash.update(location: loc) }
      end
    end
  end
end
