class UsersController < ApplicationController
    def index
    end

    def home
        @user = current_user
        render :show, :layout => 'chat'
    end

    def show
      @user = User.find(params[:id])
    end

end
