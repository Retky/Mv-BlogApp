require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Rick', photo: 'https://th.bing.com/', bio: 'Some guy') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'string'
    expect(subject).to_not be_valid
  end

  it ':recent_posts should return 3 most recent posts' do
    5.times do
      Post.create(title: 'Some title', text: 'Some text', author_id: subject.id)
    end
    expect(subject.recent_posts.count).to eq(3)
  end
end
