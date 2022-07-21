class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
  after_save :update_user_posts_counter

  def as_json(_options = {})
    super(only: %i[id title text author_id created_at updated_at comments_counter likes_counter])
  end

  private

  def update_user_posts_counter
    user.increment!(:posts_counter)
  end
end
