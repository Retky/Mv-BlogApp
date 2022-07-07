require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Rick', photo: 'https://th.bing.com/', bio: 'Some guy')
  subject { Post.new(title: 'Some title', text: 'Some text', author_id: user.id) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be less than 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'belongs to an author' do
    expect(subject.author_id).to eq(user.id)
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it ':recent_comments should return 5 most recent comments' do
    6.times do
      Comment.create(text: 'Some text', post_id: subject.id, author_id: user.id)
    end
    expect(subject.recent_comments.count).to eq(5)
  end
end
