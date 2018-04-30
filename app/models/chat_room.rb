class ChatRoom < ApplicationRecord
  has_many :users, through: :user_chat_rooms
  has_many :messages
end
