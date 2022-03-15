require 'cucumber/rails'

    Capybara.register_driver :selenium do |app|
      http_client = Selenium::WebDriver::Remote::Http::Default.new
      http_client.read_timeout = 180

      browser_options = Selenium::WebDriver::Firefox::Options.new
      browser_options.args << '--headless'
      Capybara::Selenium::Driver.new(
        app,
        browser: :firefox,
        options: browser_options,
        http_client: http_client
      )
    end

    Capybara.server = :webrick
    Cucumber::Rails::Database.autorun_database_cleaner = false