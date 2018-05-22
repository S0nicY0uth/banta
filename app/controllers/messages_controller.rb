class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @chat_room = ChatRoom.find(params[:chat_room_id])  
    @messages = @chat_room.messages.all

    respond_to do |format|
      format.html { render :index, layout:false }
      format.json
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show

  end

  # GET /messages/new
  def new
    # @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
      @chat_room = ChatRoom.find(params[:chat_room_id])
      @message = Message.new(chat_room: @chat_room, user: current_user, content: params[:content])
      

    respond_to do |format|
      if @message.save

        @message.push_message(current_user, 'json')

        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { head :created }
      else
        format.html { 
          flash[:notice] = "Unable to post message"
          redirect_to chat_room_path(@chat_room)
          }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
  
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_message
  #     @message = Message.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def message_params
  #     params.require(:message).permit(:content)
  #   end
end


