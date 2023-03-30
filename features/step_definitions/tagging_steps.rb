Given(/^I am a professional and I am on my profile page$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit "/show_profile"
  end
  
  And(/^I want to add collaborators in one of my projects$/) do
    expect(page).to have_content("Gallery Pictures")
    expect(page).to have_css('.photo-type-line', count: 1)
    expect(page).to have_css('.photo-type-line') do |cards|
        cards.each do |card|
          expect(card).to have_css('img[src*="uploads/gallery/gallery_picture/"]')
          expect(card).to have_css('.headline', text: /[a-zA-Z]/)
          expect(card).to have_css('.desc', text: /[a-zA-Z]/)
        end
      end
    # sleep(inspection_time=10)
end

  When(/^I select other users name in the list for that project$/) do
    expect(page).to have_content("Collaborators:")
    expect(page).to have_selector(".collab a", text: "Andrea.Picardo@example.com", count: 0)
    
    expect(page).to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='1']")
    expect(page).to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='3']")
    
    select "Andrea.Picardo@example.com", from: "gallery_tagging[tagged_user_id][]"
  end

  And(/^I click on tag button$/) do
    click_on "Tag"
  end
  
  Then(/^I should be able to see collaborators added to my project$/) do
    expect(page).to have_content("Collaborators:")
    expect(page).to have_selector(".collab a", text: "Andrea.Picardo@example.com", count: 1)

  end
  
  Given(/^I am a professional and I am on profile page of some other user who has projects$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com").userKey)
  end
  
  Then(/^I should not be able to see the option to tag collaborators in their project$/) do
    expect(page).to have_content("Collaborators:")
    expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='2']")
    expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='3']")
    
  end
  
  Given(/^I am a professional but not logged in$/) do
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com").userKey)
    
  end
  
  Then(/^I should not be able to see the option to tag collaborators in projects$/) do
    expect(page).to have_content("Collaborators:")
    expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='1']")
    expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='2']")
    expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='3']")
  end
  
  
  Given(/^I am a professional$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
  end
  
  Given(/^I visit profile page of some other user$/) do
    GalleryTagging.new(gallery_id: 3, general_info_id: 3).save!
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com").userKey)
  end
  
  Then(/^I can see their projects$/) do
    expect(page).to have_content("Gallery Pictures")
    expect(page).to have_css('.photo-type-line', count: 1)
    expect(page).to have_css('.photo-type-line') do |cards|
        cards.each do |card|
          expect(card).to have_css('img[src*="uploads/gallery/gallery_picture/"]')
          expect(card).to have_css('.headline', text: /[a-zA-Z]/)
          expect(card).to have_css('.desc', text: /[a-zA-Z]/)
        end
      end
  end
  
  Then(/^the collaborators of their projects$/) do
    expect(page).to have_selector(".collab a", text: "Jack.Sparrow@example.com", count: 1)
  end
  
  Given(/^I am a professional with projects and I am on my project page$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit "/show_profile"
    visit "/galleries/show?project_key=1"
  end

  Given(/^I want to add a collaborator who is not registered$/) do
    user = GeneralInfo.find_by(emailaddr: "Mona.Lisa@example.com")
    expect(user).to be_nil
  end
  
  When(/^I write their email in the invite users textbox$/) do
    fill_in "gallery_tagging[invited_email]", with: "Mona.Lisa@example.com"
    @host = 'localhost:3000'
    click_on "Tag"
  end
  
  Then(/^they should receive invitation mail$/) do
    invitation_email = ActionMailer::Base.deliveries.last
    expect(invitation_email.to).to eq(["Mona.Lisa@example.com"])
    expect(invitation_email.subject).to eq("You have been invited to collaborate on a project.")

    expect(invitation_email.body).to include("Hello Mona.Lisa@example.com,")
    expect(invitation_email.body).to include("Anthony.Gray@example.com is inviting you to collaborate on the project <b>Test Gallery 1</b>.")
    expect(invitation_email.body).to include("<p><a href=\"http://localhost:3000/galleries/show?project_key=1\">Link to project.</a></p>")
  
  end
