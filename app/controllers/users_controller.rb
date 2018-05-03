class UsersController < ApplicationController
    def index
    end

    def home
    	if user_signed_in?
        @user = current_user
        render :show, :layout => 'chat'
      else 
      	render :index 
      end
    end

    def show
      @user = User.find(params[:id])
      @chat_rooms = ChatRoom.all
    end

end
