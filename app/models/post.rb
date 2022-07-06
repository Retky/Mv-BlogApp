class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :comments
  has_many :likes

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
  after_save :update_user_posts_counter

  private

  def update_user_posts_counter
    user.increment!(:posts_counter)
  end
end
