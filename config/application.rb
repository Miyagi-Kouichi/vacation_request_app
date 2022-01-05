require_relative 'boot'

require 'rails/all'


Bundler.require(*Rails.groups)

module VacationRequestApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.time_zone = 'Asia/Tokyo'
   
  end
end
