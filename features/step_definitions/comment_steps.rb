  # Check
  Given(/^I am a logged-in user on a portfolio posting page$/) do
    # Implement the steps to log in the user and navigate to a portfolio posting page
  end
  
  And(/^there is a comment box and a submit button$/) do
    expect(page).to have_field('comment_body')
    expect(page).to have_button('Submit Comment')
  end
  
  When(/^I fill in the comment box with "(.*?)"$/) do |comment_text|
    fill_in('comment_body', with: comment_text)
  end
  
  When(/^I click the "Submit Comment" button$/) do
    click_button('Submit Comment')
  end
  
  Then(/^I should see a success message "Comment submitted successfully"$/) do
    expect(page).to have_content('Comment submitted successfully')
  end
  
  Then(/^I should be on the home page$/) do
    expect(current_path).to eq(root_path) # Adjust this based on your application's route
  end
  
  Then(/^the new comment "(.*?)" should be displayed$/) do |comment_text|
    expect(page).to have_content(comment_text)
  end
  

  # Users cannot submit an empty comment
  Given(/^I am a logged-in user on a portfolio posting page$/) do
    # Implement the steps to log in the user and navigate to a portfolio posting page
  end
  
  And(/^there is a comment box and a submit button$/) do
    expect(page).to have_field('comment_body')
    expect(page).to have_button('Submit Comment')
  end
  
  When(/^I leave the comment box empty$/) do
    # Leave the comment box empty (do not fill it in)
  end
  
  When(/^I click the "Submit Comment" button$/) do
    click_button('Submit Comment')
  end
  
  Then(/^I should see an error message "Comment cannot be empty"$/) do
    expect(page).to have_content('Comment cannot be empty')
  end
  
  Then(/^the comment should not be posted$/) do
    expect(Comment.count).to eq(0) # Assuming 'Comment' is the model used
  end
  