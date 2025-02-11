class Notification < ApplicationRecord
  belongs_to :user

  after_create_commit do
    NotificationChannel.broadcast_to(user, { message: message, read: read })
  end
end
