require 'rails_helper'

RSpec.feature 'AI About Me Generator', type: :feature, js:true do
  let(:user) { create(:user, email: 'user@example.com', password: 'Password123!') }
  let(:login_info) { create(:login_info, email: user.email, password: user.password) }
  let(:general_info) { create(:general_info, user: user, city: "College Station", company: "VisualTech", country: "USA", gender: "Male", industry: "Photography", specialization: "Portraits", userKey: SecureRandom.hex(10)) }

  before do
    # Simulating a login by setting the session with the user's login info
    allow_any_instance_of(ApplicationController).to receive(:session).and_return(current_user_key: general_info.userKey)

    visit general_info_edit2_path
    save_and_open_page
  end

  scenario 'clicking Generate About Me sends POST request' do
    # Stub the POST request to check if it is triggered
    expect_any_instance_of(GeneralInfoController).to receive(:generate_about_me)

    # Click the "Generate About Me" button
    click_button 'Generate About Me'
  end
  # scenario 'Generate About Me with incomplete user info' do
  #   # Check that the "Generate About Me" button is present and enabled
  #   expect(page).to have_button('Generate About Me', disabled: false)

  #   click_button 'Generate About Me'
  #   save_and_open_page
  #   # Check for missing fields prompt
  #   # expect(page).to have_content('The following details are missing:', wait: 5)
  #   # expect(page).to have_content('compensation')
  #   # expect(page).to have_content('experience')

  #   # Check if generated About Me content is visible
  #   expect(page).to have_content('About Me')
  #   expect(page).to have_content('Company: VisualTech')
  #   expect(page).to have_content('Industry: Photography')
  #   expect(page).to have_content('Specialization: Portraits')

  #   # Ensure the About Me section is editable
  #   expect(page).to have_selector('textarea#bio')
  # end
end
