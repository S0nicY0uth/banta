class AddIndexChatRoomToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :chat_room_id, :integer
    add_index :messages, :chat_room_id
  end
end
