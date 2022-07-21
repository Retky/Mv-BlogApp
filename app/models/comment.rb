class Comment < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  belongs_to :post

  after_save :update_post_comments_counter

  def as_json(_options = {})
    super(only: %i[id text author_id created_at updated_at])
  end

  private

  def update_post_comments_counter
    post.increment!(:comments_counter)
  end
end
