class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 10 }

  after_create_commit :broadcast_new_post_notification

  private

  def broadcast_new_post_notification
    ActionCable.server.broadcast(
      "notifications",
      { message: "New post created: #{self.title}" }
    )
  end
end
