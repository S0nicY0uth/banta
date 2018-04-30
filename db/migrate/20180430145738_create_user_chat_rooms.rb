class CreateUserChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_chat_rooms do |t|
      t.belongs_to :user, index: true
      t.belongs_to :chat_room, index: true
      t.timestamps
    end
  end
end
