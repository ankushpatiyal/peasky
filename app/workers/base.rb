class Base
  include Sidekiq::Worker
  sidekiq_options retry: 2
end
