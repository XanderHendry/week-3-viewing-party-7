require 'rails_helper' 

RSpec.describe 'App Authorizations' do 
  describe 'Landing page as a Visitor' do 
    it 'will not display the existing users section, if a user is not logged in' do 
      visit root_path

      expect(page).to_not have_content('Existing Users')
    end

    it 'will not allow me to navigate to the User dashboard without logging in' do 
      user1 = User.create(name: "User One", email: "user1@test.com", password: 'test', password_confirmation: 'test')
      visit user_path(user1.id)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must be logged in or registered to access the dashboard')
    end
  end

  describe 'Landing page as Registered User' do 
    it 'displays the list of existing users, but their emails are not links.' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: 'test', password_confirmation: 'test')
    user2 = User.create(name: "User Two", email: "user2@test.com", password: 'test', password_confirmation: 'test')

    visit login_path

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password

    click_button 'Log In'
    
    visit root_path

    expect(page).to have_content('Existing Users')
    expect(page).to have_content(user2.email)
    expect(page).to_not have_link(user2.email)
    end
  end

  describe 'trying to create a Viewing Party as a Visitor' do 
    it 'will redirect me to the movie show page with a message that I must be logged in' do 
      user1 = User.create(name: "User One", email: "user1@test.com", password: 'test', password_confirmation: 'test')
      movie = Movie.create(title: "Movie Title", rating: rand(1..10), description: "This is a description about Movie")

      visit movie_path(user1.id, movie.id)

      click_button 'Create a Viewing Party'

      expect(current_path).to eq(movie_path(user1.id, movie.id))
      expect(page).to have_content('You must be logged in or registered to create a movie party')
    end
  end
end 