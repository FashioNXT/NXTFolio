require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Then(/^I should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path_to(page_name))
end
