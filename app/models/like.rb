class Like < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :post

  after_save :update_post_likes_counter

  private

  def update_post_likes_counter
    post.increment!(:likes_counter)
  end
end
