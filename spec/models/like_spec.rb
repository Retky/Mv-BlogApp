require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Rick', photo: 'https://th.bing.com/', bio: 'Some guy')
  post = Post.create(title: 'Some title', text: 'Some text', author_id: user.id)
  subject { Like.new(post_id: post.id, author_id: user.id) }

  before { subject.save }

  it 'belongs to an author' do
    expect(subject.author_id).to eq(user.id)
  end

  it 'belongs to a post' do
    expect(subject.post_id).to eq(post.id)
  end
end
