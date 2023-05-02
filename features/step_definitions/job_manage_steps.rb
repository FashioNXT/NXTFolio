Given(/^I am a professional and want to see all the jobs$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    
  end
  
  And(/^I want to go to the job management page$/) do
    visit "/job_info"
  end

  Then(/^I should see all the jobs that I posted$/) do 
    expect(page).to have_content("test job title")
  end

  And(/^I want to see more infos of one specific job$/) do 
    click_on "More Infos"
  end

  And(/^I want to edit the infos of the specific job$/) do 
    click_on "Edit"
  end

  And(/^I enter the new infos of the specific job$/) do 
    fill_in 'Title', :with => 'test edit job title'
    fill_in 'Description', :with => 'test edit job description'

    fill_in 'Category', :with => 'Makers'
    fill_in 'Profession', :with => 'Other Makers'

    fill_in 'Country', :with => 'United States'
    fill_in 'State', :with => 'Texas'
    fill_in 'City', :with => 'Bryan'

    fill_in 'Lowest', :with => '200000'
    fill_in 'Highest', :with => '220000'

    click_button "Update Job Info"
  end

  Then(/^I should see the job's info is updated$/) do 
    expect(page).to have_content("test edit job title")
    expect(page).to have_content("Description: test edit job description")

    expect(page).to have_content("Category: Makers")
    expect(page).to have_content("Profession: Other Makers")

    expect(page).to have_content("Location: United States, Texas, Bryan")

    expect(page).to have_content("Salary (Annual): 200000 ~ 220000")

  end 

  And(/^I want to delete the specific job$/) do 
    click_on "Delete"
  end

#   Then(/^I should not see this job in the jobs list$/) do 
#     expect(page).to have_content("Job Title: test edit job title")
#   end