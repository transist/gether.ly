require 'rubygems'
require 'spork'

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'

  # Prevent Devise load User model, it should be load in each_run block.
  require 'rails/application'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'

  RSpec.configure do |config|
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'

    config.include Rack::Test::Methods, type: :request
    config.include RSpec::Rails::RequestExampleGroup, type: :request, example_group: {
      file_path: config.escaped_path(%w[spec api])
    }

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  require 'factory_girl_rails'

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f }

  FactoryGirl.reload
  I18n.backend.reload!
end
