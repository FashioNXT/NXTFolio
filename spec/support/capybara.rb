Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless! # Enable headless mode
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end