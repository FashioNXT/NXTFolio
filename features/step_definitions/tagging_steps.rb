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
    # expect(page).to have_css('.photo-type-line') do |cards|
    #     cards.each do |card|
    #       expect(card).to have_css('img[src*="uploads/gallery/gallery_picture/"]')
    #       expect(card).to have_css('.headline', text: /[a-zA-Z]/)
    #       expect(card).to have_css('.desc', text: /[a-zA-Z]/)
    #     end
    #   end
    # sleep(inspection_time=10)
end

  When(/^I click on Add Collaborators button$/) do
    click_on "Add Collaborators"
    expect(page).to have_content("Existing collaborators")
  end

  When(/^I search for "ja" in the search bar$/) do
    fill_in('collab-search-1', with: 'ja')
    
  end

  Then(/^I should be able to see (.*?) and (.*?) in dropdown$/) do |name1, name2|
      within('.collaborators') do
      dropdown_items = all('.all-list-1 li').map(&:text)
      expect(dropdown_items).to include(name1, name2)
    end
  end

  When(/^I select (.*?) in dropdown$/) do |name|
    within('.collaborators') do
      dropdown_items = all('.all-list-1 li').map(&:text)
      expect(dropdown_items).to include(name)
      find('.all-list-1 li', text: name).click
    end
  end

  And(/^I click on tag button$/) do
    click_on "Tag"
  end
  
  Then(/^I should see (.*?) added as collaborator in my project$/) do |collaborator_name|
    expect(page).to have_content("Collaborators:")
    expect(page).to have_content(collaborator_name)
  end

  # Then(/^I should be able to see collaborators added to my project$/) do
  #   expect(page).to have_content("Collaborators:")
  #   expect(page).to have_selector(".collab a", text: "Andrea.Picardo@example.com", count: 1)

  # end
  
  Given(/^I am a professional and I am on profile page of some other user who has projects$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com").userKey)
  end
  
  Then(/^I should not be able to see the option to tag collaborators in their project$/) do
    expect(page).not_to have_button("Add Collaborators")
    #expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='2']")
    #expect(page).not_to have_selector("select[name='gallery_tagging[tagged_user_id][]'] option[value='3']")
    
  end
  
  Given(/^I am a professional but not logged in$/) do
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "Andrea.Picardo@example.com").userKey)
    
  end
  
  Then(/^I should not be able to see the option to tag collaborators in projects$/) do
    expect(page).not_to have_button("Add Collaborators")
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
    # expect(page).to have_css('.photo-type-line') do |cards|
    #     cards.each do |card|
    #       expect(card).to have_css('img[src*="uploads/gallery/gallery_picture/"]')
    #       expect(card).to have_css('.headline', text: /[a-zA-Z]/)
    #       expect(card).to have_css('.desc', text: /[a-zA-Z]/)
    #     end
    #   end
  end
  
  Then(/^the collaborators of their projects$/) do
    expect(page).to have_selector(".collab a", text: "Jack Sparrow", count: 1)
  end
  
  Given(/^I am a professional with projects and I am on my profile page$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    visit "/show_profile" 
  end

  Given(/^I want to add a collaborator who is not registered$/) do
    user = GeneralInfo.find_by(emailaddr: "Mona.Lisa@example.com")
    expect(user).to be_nil
  end
  
  And(/^I write their email in the invite users textbox$/) do
    within('.collaborators') do
    fill_in "gallery_tagging[invited_email]", with: "Mona.Lisa@example.com"
    @host = 'localhost:3000'
    end
  end
  
  Then(/^they should receive invitation mail$/) do
    invitation_email = ActionMailer::Base.deliveries.last
    expect(invitation_email.to).to eq(["Mona.Lisa@example.com"])
    expect(invitation_email.subject).to eq("You have been invited to collaborate on a project.")

    expect(invitation_email.body).to include("Hello Mona.Lisa@example.com,")
    expect(invitation_email.body).to include("Anthony.Gray@example.com is inviting you to collaborate on the project <b>Test Gallery 1</b>.")
    expect(invitation_email.body).to include("<p><a href=\"http://localhost:3000/galleries/show?project_key=1\">Link to project.</a></p>")
  
  end

  When(/^I add (.*?) as collaborator in my project$/) do |name|
    expect(page).to have_content("Gallery Pictures")
    expect(page).to have_css('.photo-type-line', count: 1)
    # expect(page).to have_css('.photo-type-line') do |cards|
    #     cards.each do |card|
    #       expect(card).to have_css('img[src*="uploads/gallery/gallery_picture/"]')
    #       expect(card).to have_css('.headline', text: /[a-zA-Z]/)
    #       expect(card).to have_css('.desc', text: /[a-zA-Z]/)
    #     end
    #   end
    click_on "Add Collaborators"
    expect(page).to have_content("Existing collaborators")
    fill_in('collab-search-1', with: 'ja')
    within('.collaborators') do
      dropdown_items = all('.all-list-1 li').map(&:text)
      expect(dropdown_items).to include(name)
      find('.all-list-1 li', text: name).click
    end
    click_on "Tag"
    expect(page).to have_content("Collaborators:")
    expect(page).to have_content(name)
  end

  And(/^I visit their profile$/) do
    visit show_profile_show_profile_path(:user_key => GeneralInfo.find_by(emailaddr: "James.Lawrence@example.com").userKey)
  end
  Then(/^I should see my project in their collaborated projects$/) do
    within(".collaborated-galleries") do
      expect(page).to have_content("Collaborated Galleries")
      find(".profile-img-container").hover
      expect(find("a.photo-hover[href='/galleries/show?project_key=1']")).to be_visible
      #link = find('a.photo-hover[href="/galleries/show?project_key=1"]')
      #expect(link).to be_visible
    end
  end

