require 'rails_helper'

RSpec.describe 'Registering a new user' do
  describe 'as a visitor' do
    before(:each) do
      visit new_user_path
    end

    it 'loads the page' do
      expect(current_path).to eq(new_user_path)
      expect(status_code).to eq(200)
    end

    it 'I can register' do
      expect(page).to have_link('Login with Google')
      # TODO: expect(page).to have_selector(:css, "a[href=\"#{ ??? }\"]")
      expect(page).to have_link('Login with Twitter')
      # TODO: expect(page).to have_selector(:css, "a[href=\"#{ ??? }\"]")
      
      username = 'BobTheBuilder'
      username_downcased = username.downcase
      password = 'supersecurepassword'

      fill_in 'user[username]', with: username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_button('Make an Account')
      
      expect(current_path).to eq(landmarks_path)
      expect(User.count).to eq(1)
      
      expect(page).to have_content("Welcome, #{username_downcased}!")
      expect(page).to have_link('Log Out')
      expect(page).to have_selector(:css, "a[href=\"#{ logout_path }\"]")
      expect(page).to_not have_link('Login')
      expect(page).to_not have_link('Register')
    end

    xit 'I cannot register with a duplicate username' do
      username = 'BobTheBuilder'
      username_downcased = username.downcase
      password = 'supersecurepassword'

      create(:user, username: username_downcased)

      fill_in 'user[username]', with: username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_button('Make an Account')
      
      expect(current_path).to eq(new_user_path)
      expect(User.count).to eq(1)
      
      expect(page).to have_content('lsdkjfalksdjfa')
      expect(page).to_not have_content("Welcome, #{username}!")

      expect(page).to_not have_link('Log Out')
      expect(page).to have_link('Login')
      expect(page).to have_link('Register')
    end

    it "I cannot register if passwords don't match" do
      username = 'BobTheBuilder'
      password = 'supersecurepassword'

      fill_in 'user[username]', with: username
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: 'extra' + password
      click_button('Make an Account')
      
      expect(page).to have_field('user[password_confirmation]')
      expect(User.count).to eq(0)
      
      expect(page).to have_content("Password confirmation doesn't match")
      expect(page).to_not have_content("Welcome, #{username}!")

      expect(page).to_not have_link('Log Out')
      expect(page).to have_link('Login')
      expect(page).to have_link('Register')
    end

    it 'I cannot register if I leave username blank' do
      password = 'supersecurepassword'

      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_button('Make an Account')
      
      expect(page).to have_field('user[password_confirmation]')
      expect(User.count).to eq(0)
      
      expect(page).to have_content("Username can't be blank")
      expect(page).to_not have_content("Welcome, ")

      expect(page).to_not have_link('Log Out')
      expect(page).to have_link('Login')
      expect(page).to have_link('Register')
    end

    it 'I cannot register if I leave password blank' do
      username = 'BobTheBuilder'

      fill_in 'user[username]', with: username
      click_button('Make an Account')
      
      expect(page).to have_field('user[password_confirmation]')
      expect(User.count).to eq(0)
      
      expect(page).to have_content("Password can't be blank")
      expect(page).to_not have_content("Welcome, #{username.downcase}")

      expect(page).to_not have_link('Log Out')
      expect(page).to have_link('Login')
      expect(page).to have_link('Register')
    end
  end
end
