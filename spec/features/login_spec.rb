require 'rails_helper'

RSpec.describe "Log In Page" do
  it 'lets me log in with my unique email and password and takes me to my dashboard' do
    user = User.create(name: 'User One', email: 'unique@example.com', password: 'password1', password_confirmation: 'password1')
    visit root_path

    expect(page).to have_link('Log In')
    
    click_link('Log In')
    
    expect(current_path).to eq(login_path)

    fill_in :email, with:'unique@example.com'
    fill_in :password, with: 'password1'
    click_button 'Log In'
    

    expect(current_path).to eq(user_path(user.id))
    
    expect(page).to have_content("User One's Dashboard")
  end 
end