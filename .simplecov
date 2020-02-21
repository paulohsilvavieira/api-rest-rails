SimpleCov.start 'rails' do
  add_filter 'vendor'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/mailers/'
  add_filter 'app/lib/'
  add_filter 'app/models/application_record.rb'
  add_filter 'app/jobs/application_job.rb'
end