require 'rails_helper'

# RSpec.describe "messages/index", type: :view do

#   let(:valid_user){
#     User.create!(name:'BigBadUser', email:'bigbademail@gmail.com', password: 'pass123')
#   }

#   let(:valid_chat_room){
#     ChatRoom.create!(name:'BigBadChatRoom')
#   }

#   before(:each) do
#     @user = valid_user
#     @chat_room = valid_chat_room

#     assign(:messages, [
#       Message.create!(
#         :content => "Content",
#         :user => @user,
#         :chat_room => @chat_room
#       ),
#       Message.create!(
#         :content => "Content",
#         :user => @user,
#         :chat_room => @chat_room
#       )
#     ])
#   end

#   it "renders a list of messages" do
#     render
#     assert_select "div.bubble", :text => "Content".to_s, :count => 2
#   end
# end
