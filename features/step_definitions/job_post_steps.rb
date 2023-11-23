Given(/^I am a professional and want to post a new job$/) do
    visit root_path
    click_on "Sign In"
    fill_in "Your Email", :with => "Anthony.Gray@example.com"
    fill_in "Your Password", :with => "Test1234!"
    click_on "SIGN IN"
    
  end
  
  And(/^I want to go to the jobs page$/) do
    click_on "Jobs"
  end

  When(/^I click on "Post Job" from the menu$/) do
    click_on "Post Job"
  end
  
  Then(/^I should be able to see the job posting page$/) do
    expect(current_path).to include('job_info/new_job')
  end
  
  When(/^I fill in the job posting form with details$/) do
    fill_in 'title', :with => 'test job title'
    fill_in 'description', :with => 'test job description'
    select 'Creators', from: 'category'
    select 'Brand Owner', from: 'profession'
    # select 'United States', from: 'country'
    # select 'Washington', from: 'state'
    # select 'Seattle', from: 'city'
    fill_in 'low_salary', :with => '100000'
    fill_in 'high_salary', :with => '120000'
  end
  
  # And(/^I click on "SAVE and Post Job" button$/) do
  #   click_button('SAVE and Post Job')
  # end
  
  Then(/^I should see job post success message$/) do
    expect(page).to have_content("Job info created successfully")
  end
  
  