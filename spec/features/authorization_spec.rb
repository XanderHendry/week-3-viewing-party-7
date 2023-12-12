require 'rails_helper' 

RSpec.describe 'App Authorizations' do 
  describe 'Landing page as a Visitor' do 
    it 'will not display the existing users section, if a user is not logged in' do 
      visit root_path

      expect(page).to_not have_content('Existing Users')
    end
  end
end 