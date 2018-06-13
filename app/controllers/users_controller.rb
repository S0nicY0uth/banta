class UsersController < ApplicationController
    def index
      if user_signed_in?
        redirect_to :home, :layout => 'chat'
      else
        redirect_to new_user_session_path
      end
    end

    def home
      if user_signed_in?
        @chat_rooms = ChatRoom.all
        @user = current_user
        render :show, :layout => 'chat'
      else 
      	redirect_to new_user_session_path
      end
    end

    def show
      @user = User.find(params[:id])
      @chat_rooms = ChatRoom.all
    end

end
