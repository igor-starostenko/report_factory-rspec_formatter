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
  let(:passed_test_json) do
    file_path = '../fixtures/passed_rspec_example.json'
    JSON.parse(File.read(File.expand_path(file_path, __FILE__)))
  end

  it 'submits a passed test report to ReportFactory' do
    response = described_class.send_report(passed_test_json)
    expect(response).to be_truthy
    expect(response.code).to eql('201')
    expect(response.msg).to eql('Created')
  end

  let(:failed_test_json) do
    file_path = '../fixtures/failed_rspec_example.json'
    JSON.parse(File.read(File.expand_path(file_path, __FILE__)))
  end

  it 'submits a failed test report to ReportFactory' do
    response = described_class.send_report(failed_test_json)
    expect(response).to be_truthy
    expect(response.code).to eql('201')
    expect(response.msg).to eql('Created')
  end
end
