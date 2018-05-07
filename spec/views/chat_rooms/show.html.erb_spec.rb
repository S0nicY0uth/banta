require 'rails_helper'

RSpec.describe "chat_rooms/show", type: :view do
  before(:each) do
    @chat_room1 = assign(:chat_room, ChatRoom.create!(
      :name => "Chat Room 1"
    ))
    @chat_room2 = assign(:chat_room, ChatRoom.create!(
      :name => "Chat Room 2"
    ))
    @chat_rooms = [@chat_room1, @chat_room2]
  end

  it "renders the chat room names" do
    render
    expect(rendered).to match('Chat Room 1')
    expect(rendered).to match('Chat Room 2')
  end
end
