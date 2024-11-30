When /I select "(.+)" chat/ do |user|
    visit page.find('a', text: user)['href']
end

Then /I should visit chat with "(.+)"/ do |user|
    name = user.split(".")
    email = "#{name[0]}.#{name[1]}@example.com"
    id = GeneralInfo.find_by(emailaddr: email).id

    expect(current_path).to eq("/dm/#{id}")
end

Then /I should see the chat history/ do
    expect(page).to have_css('.message-box')
end

When /I attach the file "(.+)" to "(.+)"/ do |file_path, field|
    attach_file(field, File.absolute_path('app/assets/images/4.jpg'), make_visible: true)
end

Then /I should see the file "(.+)"/ do |file_name|
    expect(page).to have_link(file_name)
end