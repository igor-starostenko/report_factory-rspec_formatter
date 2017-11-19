# frozen_string_literal: true

require 'report_factory/rspec/api'

RSpec.describe ReportFactory::Rspec::API, :api do
  before do
    ReportFactory::Rspec.configure do |config|
      config.url = 'http://0.0.0.0:3000'
      config.project_name = 'webapp'
      config.auth_token = '9e04136f-c71d-4d16-924a-216e9af08903'
    end
  end
  let(:report_hash) {
    JSON.parse('{"version":"3.7.0","messages":["Run options: include {:models=\u003etrue}","\nAll examples were filtered out"],"examples":[],"summary":{"duration":0.000495,"example_count":0,"failure_count":0,"pending_count":0,"errors_outside_of_examples_count":0},"summary_line":"0 examples, 0 failures"}')
  }

  it 'sends report to ReportFactory' do
    response = described_class.send_report(report_hash)
    expected(response).to be_truthy
    expected(response.code).to eql(200)
  end
end
