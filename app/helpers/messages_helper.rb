module MessagesHelper

    def format_time(message)
        message.created_at.strftime("%a %I:%M")
    end

end
