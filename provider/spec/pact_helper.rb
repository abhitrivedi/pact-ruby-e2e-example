require_relative '../bar_app.rb'

Pact.configuration.reports_dir = "./provider/reports"

Pact.service_provider "Bar" do
  app { BarApp.new }
  app_version '1.2.3'
  publish_verification_results !!ENV['PUBLISH_VERIFICATIONS_RESULTS']

  honours_pact_with 'Foo' do
    pact_uri './consumer/spec/support/foo-bar.json'
  end
end

# When conusmer interaction has no provider state then these global and base states do not get executed.
Pact.provider_states_for 'Foo' do
  set_up do
    p 'Inside base provider set_up for Foo'
  end

  tear_down do
    p 'Inside base provider tear_down for Foo'
  end
end

Pact.set_up do
  p 'Inside global provider set_up'
end

Pact.tear_down do
  p 'Inside global tear_down'
end
