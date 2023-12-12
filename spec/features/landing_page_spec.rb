require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: 'test', password_confirmation: 'test')
    user2 = User.create(name: "User Two", email: "user2@test.com", password: 'test', password_confirmation: 'test')
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users after logging in' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: 'test', password_confirmation: 'test')
    user2 = User.create(name: "User Two", email: "user2@test.com", password: 'test', password_confirmation: 'test')

    visit login_path

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password

    click_button 'Log In'

    visit root_path

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 
end
