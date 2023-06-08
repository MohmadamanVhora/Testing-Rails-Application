require 'rails_helper'

RSpec.feature 'User sign in', type: :feature do
  before do
    @user = create(:user)
    visit new_user_session_path
  end

  it 'with valid credentials user should signed in' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path root_path
  end

  it 'with unregistered account user should not signed in' do
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: '000000'
    click_button 'Log in'
    expect(page).not_to have_content 'Signed in successfully.'
    expect(page).to have_current_path new_user_session_path
  end

  it 'with invalid password user should not signed in' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: '000000'
    click_button 'Log in'
    expect(page).not_to have_content 'Signed in successfully.'
    expect(page).to have_current_path new_user_session_path
  end
end
