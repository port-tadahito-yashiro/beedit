require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Beedit
  class Application < Rails::Application

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    #
    # RSpec対応の記述(http://qiita.com/yuutetu/items/135b1c8ab512208aebfe)
    #
    #
    #
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.template_engine false
      g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # ip制限
    #config.middleware.use Rack::Access, {
    #    '/super' => ['192.168.100.200']
    #}

    # cron用の設定
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]


    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    #config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += Dir["#{config.root}/lib"]
  end
end
