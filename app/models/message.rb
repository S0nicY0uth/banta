class Message < ApplicationRecord
    belongs_to :user
    belongs_to :chat_room

    validates :content, presence: true
    validates :user, presence: true
    validates :chat_room, presence: true

    def push_message(current_user)
        ActionCable.server.broadcast "MessagesChannel:#{chat_room.id}", message: to_html(current_user)
    end

    def to_html(current_user)
        rendered = ApplicationController.render(
        :partial => 'messages/messagereload',
        :locals => {message: self, current_user: current_user}
        )
    end
    #ask ben about his to_html method
end
