# frozen_string_literal: true

require 'report_factory/rspec/api'

RSpec.describe ReportFactory::Rspec::API, :api do
  let(:base_url) { 'http://0.0.0.0:3000' }
  let(:test_url) { 'http://0.0.0.0:9000' }
  let(:project_name) { 'webapp' }
  let(:endpoint) { "#{test_url}/api/v1/projects/#{project_name}/reports/rspec" }
  let(:tags) { %w[Regression High] }
  let(:auth_token) { '82f551b8-dea9-4385-9c4f-d290688391cc' }

  before do
    ReportFactory::Rspec.configure do |config|
      config.url = test_url
      config.project_name = project_name
      config.tags = tags
      config.auth_token = auth_token
    end
  end

  after do
    ReportFactory::Rspec.url = base_url
  end

  let(:passed_test) do
    file_path = '../fixtures/passed_rspec_example.json'
    JSON.parse(File.read(File.expand_path(file_path, __FILE__)))
  end

  it 'submits a passed test report to ReportFactory', :passed do
    headers = ReportFactory::Rspec::API.format_headers
    payload = ReportFactory::Rspec::API.format_payload(passed_test).to_json

    stub_request(:post, endpoint)
      .with(body: payload)
      .to_return(status: 201)

    response = described_class.send_report(passed_test)

    expect(
      a_request(:post, endpoint)
        .with(headers: headers, body: payload)
    ).to have_been_made.once

    expect(response).to be_truthy
    expect(response.code).to eql('201')
  end

  let(:failed_test) do
    file_path = '../fixtures/failed_rspec_example.json'
    JSON.parse(File.read(File.expand_path(file_path, __FILE__)))
  end

  it 'submits a failed test report to ReportFactory', :failed do
    headers = ReportFactory::Rspec::API.format_headers
    payload = ReportFactory::Rspec::API.format_payload(failed_test).to_json

    stub_request(:post, endpoint)
      .with(body: payload)
      .to_return(status: 201)

    response = described_class.send_report(failed_test)

    expect(
      a_request(:post, endpoint)
        .with(headers: headers, body: payload)
    ).to have_been_made.once

    expect(response).to be_truthy
    expect(response.code).to eql('201')
  end
end
