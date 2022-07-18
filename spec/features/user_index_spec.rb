require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before :each do
    User.destroy_all

    @user = User.new(name: 'John', photo: '', bio: 'Something')
    @user2 = User.new(name: 'Jane', photo: '', bio: 'Nothing')
    @user3 = User.new(name: 'Jack', photo: '', bio: 'Teacher')
    @user.save
    @user2.save
    @user3.save

    visit '/users'
  end

  it 'should show the user name of all users' do
    expect(page).to have_content('John')
    expect(page).to have_content('Jane')
    expect(page).to have_content('Jack')
  end

  it 'should show the profile photo of all users' do
    expect(page).to have_css('img')
  end

  it 'should show the number of posts of all users' do
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
    expect(page).to have_content("Number of posts: #{@user2.posts.count}")
    expect(page).to have_content("Number of posts: #{@user3.posts.count}")
  end

  it 'should redirect to the user show page when the user name is clicked' do
    click_link 'John'
    expect(page).to have_content('John')
    expect(page).to have_current_path("/users/#{@user.id}")
  end
end
