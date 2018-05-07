require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  let(:valid_user){
    User.create!(name:'BigBadUser', email:'bigbademail@gmail.com', password: 'pass123')
  }

  let(:valid_chat_room){
    ChatRoom.create!(name:'BigBadChatRoom')
  }

  before do 
    @user = valid_user
    sign_in @user
    @chat_room = valid_chat_room

    other_room = ChatRoom.create!(name: 'Another Chat Room')
    @msg1 = Message.create!(content: 'blah blah', user: @user, chat_room: @chat_room)
    @msg2 = Message.create!(content: 'content', user: @user, chat_room: @chat_room)
    @msg3 = Message.create!(content: 'content', user: @user, chat_room: other_room)
  end

  let(:valid_attributes) {
    {content: 'I am content'}
  }

  let(:invalid_attributes) {
    {content: ''}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    context "with valid params" do
      it "should know all the messages that belong to the given chat_room" do
        get :index, params: {chat_room_id: @chat_room}, session: valid_session
        expect(assigns(:messages)).to eq([@msg1,@msg2])
      end

      render_views
      it "should render the messages partial" do 
        get :index, params: {chat_room_id: @chat_room}, session: valid_session
        expect(response).to render_template(partial: '_message')
      end 
    end
  end


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, params: {chat_room_id: @chat_room, user: @user, content: valid_attributes}, session: valid_session
        }.to change(Message, :count).by(1)
      end

      it "redirects to the created message" do
        post :create, params: {chat_room_id: @chat_room, message: valid_attributes}, session: valid_session
        expect(response).to redirect_to chat_room_path(@chat_room)
      end
    end

    context "with invalid params" do
      it "returns a flash notice response and returns you to the chat" do
        post :create, params: {chat_room_id: @chat_room, message: invalid_attributes}, session: valid_session
        expect(controller).to set_flash
        expect(response).to redirect_to chat_room_path(@chat_room)
      end
    end


  end
end
