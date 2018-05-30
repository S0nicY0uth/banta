class Message < ApplicationRecord
    belongs_to :user
    belongs_to :chat_room

    validates :content, presence: true
    validates :user, presence: true
    validates :chat_room, presence: true

    def push_message(current_user, format_type)
        if format_type == 'html'
            ActionCable.server.broadcast "MessagesChannel:#{chat_room.id}", message: to_html(current_user)
        else          
            ActionCable.server.broadcast "MessagesChannel:#{chat_room.id}", message: to_json
        end
    end

    def to_html(current_user)
        rendered = ApplicationController.render(
        :partial => 'messages/messagereload',
        :locals => {message: self, current_user: current_user}
        )
    end

    def to_json
        JSON.generate({content: content, user: user.name, user_id: user.id, created_at: created_at})
    end
    
end
