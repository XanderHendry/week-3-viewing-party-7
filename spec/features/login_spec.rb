require 'rails_helper'

RSpec.describe "Log In Page" do
  it 'lets me log in with my unique email and password and takes me to my dashboard' do
    user = User.create(name: 'User One', email: 'unique@example.com', password: 'password1', password_confirmation: 'password1')
    visit root_path

    expect(page).to have_link('Log In')
    
    click_link('Log In')
    
    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button 'Log In'

    
    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content("User One's Dashboard")
  end 
  
  it 'cannot log in with bad credentials' do 
    user = User.create(name: 'User One', email: 'unique@example.com', password: 'password1', password_confirmation: 'password1')

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: "gabagool"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it 'lets me log out, after succesfully logging in' do
    user = User.create(name: 'User One', email: 'unique@example.com', password: 'password1', password_confirmation: 'password1')
    
    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button 'Log In'
    
    visit root_path
    
    expect(page).to_not have_link('Log In')
    expect(page).to have_link('Log Out')
    click_link('Log Out')

    expect(current_path).to eq(root_path)

    expect(page).to_not have_link('Log Out')
    expect(page).to have_link('Log In')
  end 
end