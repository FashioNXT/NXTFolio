Given(/^no usage statistics exist$/) do
    get "/api/general_info"
    response_body = JSON.parse(last_response.body)
    expect(response_body).to include("user_info")
    expect(response_body["user_info"].size).to be 0
end

When(/^(.*) (.*) login to account$/) do |firstname,lastname|
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => firstname+"."+lastname+"@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit "/show_profile"
end

And(/^perform some activities and logs out$/) do
    sleep(inspection_time=10)
    visit root_path
    sleep(inspection_time=10)
    visit "/show_profile"
    sleep(inspection_time=10)
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com").userKey)
    sleep(inspection_time=20)
    visit root_path
    sleep(inspection_time=10)
    visit "/show_profile"
    sleep(inspection_time=10)
    click_on "Log out"
end

When(/^I visit \/api\/general_info page$/) do
    get "/api/general_info"
end

Then(/^I should see their usage time$/) do
    response_body = JSON.parse(last_response.body)
    expect(response_body).to include("user_info")
    expect(response_body["user_info"]).to be_an(Array)
    expect(response_body["user_info"].size).to be >= 1

    user_names = response_body["user_info"].map { |user| user["name"] }
    expect(user_names).to include("James Lawrence").or include("Andrea Picardo").or include("Jack Sparrow")
    expect(user_names).not_to include("Anthony Gray")

    user_info = response_body["user_info"]
    expect(user_info).to be_an(Array)
    user_info.each do |user|
        expect(user).to include("name")
        expect(user).to include("average_minutes_used_last_30_days")
        expect(user["name"]).to be_an(String)
        expect(user["average_minutes_used_last_30_days"]).to be_an(Integer)
        expect(user["average_minutes_used_last_30_days"]).to be > 0
    end
end
