require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Peasky
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_paths += Dir[ Rails.root.join('lib', '**/') ]
    config.active_job.queue_adapter = :sidekiq
    config.cache_store = :redis_cache_store, {
      url: ENV["REDIS_URL"],
      pool_size: 8,
      pool_timeout: 6
    }
  end
end
