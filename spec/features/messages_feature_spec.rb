require "rails_helper"

RSpec.describe "Messaging system", :type => :feature do

    let(:valid_user){
        User.create!(name:'BigBadUser', email:'bigbademail@gmail.com', password: 'pass123')
    }

    let(:valid_chat_room){
        ChatRoom.create!(name:'BigBadChatRoom')
    }

    before :each do
        @user = valid_user
        @chat_room = valid_chat_room
        @other_room = ChatRoom.create!(name:'Other')
        @msg1 = Message.create!(content: 'blah blah', user: @user, chat_room: @chat_room)
        @msg2 = Message.create!(content: 'content', user: @user, chat_room: @chat_room)
        @msg3 = Message.create!(content: 'lol omg m8 lolz', user: @user, chat_room: @other_room)
    end

    def login(user)
        visit '/'
        click_link('Login')
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: 'pass123'    
        click_button('Log in')
        expect(page).to have_text 'Please choose a chat room from the left hand side'
    end

    describe 'viewing messages' do
        it 'should allow me to view the messages associated with a specific room' do
           login(@user)
           visit chat_room_path(@chat_room)
           expect(page).to have_text 'blah blah'
           expect(page).to have_text 'content'
        end
        it 'the viewable messages should not include those belonging to other rooms', js: true do
            login(@user)
            visit chat_room_path(@chat_room)
            expect(page).not_to have_text 'lol omg m8 lolz'
         end
    end

    describe 'sending a new message' do
        it 'should allow me to post a new message to a chat room', js: true do 
            login(@user)
            visit chat_room_path(@chat_room)
            fill_in 'content', with: "My message yo!"
            click_button 'Godspeed!'
            expect(page).to have_text("My message yo!")
        end
    end

end