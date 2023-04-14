When /I select "(.+)" chat/ do |user|
    visit page.find('a', text: user)['href']
end

Then /I should visit chat with "(.+)"/ do |user|
    name = user.split(".")
    email = "#{name[0]}.#{name[1]}@example.com"
    id = GeneralInfo.find_by(emailaddr: email).id

    expect(current_path).to eq("/dm/#{id}")
end
