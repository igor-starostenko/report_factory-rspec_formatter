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
  let(:report_hash) do
    '{"version":"3.7.0","messages":["Run options: include {:user_reports_api=\u003etrue}"],"examples":[{"id":"./spec/requests/user_reports_api_spec.rb[1:1:1]","description":"is not authorized without X-API-KEY","full_description":"UserReports GET index is not authorized without X-API-KEY","status":"passed","file_path":"./spec/requests/user_reports_api_spec.rb","line_number":27,"run_time":0.460698,"pending_message":null},{"id":"./spec/requests/user_reports_api_spec.rb[1:1:2]","description":"doesn\'t expose X-API-KEY","full_description":"UserReports GET index doesn\'t expose X-API-KEY","status":"passed","file_path":"./spec/requests/user_reports_api_spec.rb","line_number":39,"run_time":0.055454,"pending_message":null},{"id":"./spec/requests/user_reports_api_spec.rb[1:1:3]","description":"gets all reports of the requested user","full_description":"UserReports GET index gets all reports of the requested user","status":"passed","file_path":"./spec/requests/user_reports_api_spec.rb","line_number":44,"run_time":0.051019,"pending_message":null}],"summary":{"duration":0.569834,"example_count":3,"failure_count":0,"pending_count":0,"errors_outside_of_examples_count":0},"summary_line":"3 examples, 0 failures"}'
  end

  it 'sends report to ReportFactory' do
    response = described_class.send_report(JSON.parse(report_hash))
    expect(response).to be_truthy
    expect(response.code).to eql('201')
    expect(response.msg).to eql('Created')
  end
end
