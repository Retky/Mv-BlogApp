require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    User.destroy_all
    Post.destroy_all
    @user = User.new(name: 'John', photo: '', bio: 'Something')
    @user.save

    @post1 = Post.create(title: 'Post1', text: 'Text1', author_id: @user.id)
    @post2 = Post.create(title: 'Post2', text: 'Text2', author_id: @user.id)
    @post3 = Post.create(title: 'Post3', text: 'Text3', author_id: @user.id)
    @post4 = Post.create(title: 'Post4', text: 'Text4', author_id: @user.id)

    visit "/users/#{@user.id}"
  end

  it 'should show the user profile picture' do
    expect(page).to have_css('img')
  end

  it 'should show the user name' do
    expect(page).to have_content('John')
  end

  it 'should show the number of posts' do
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
    expect(page).to have_content('Number of posts: 4')
  end

  it 'should show the user bio' do
    expect(page).to have_content('Something')
  end

  it 'should show the 3 most recent posts' do
    expect(page).to_not have_content('Post1')
    expect(page).to have_content('Post2')
    expect(page).to have_content('Post3')
    expect(page).to have_content('Post4')
  end

  it 'should show a button to view all posts' do
    expect(page).to have_content('See all posts')
  end

  it 'should redirect to the post when the post title is clicked' do
    click_on 'Post2'
    expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post2.id}")
  end

  it 'should redirect to all posts page when button is clicked' do
    click_on 'See all posts'
    expect(page).to have_current_path("/users/#{@user.id}/posts")
  end
end
