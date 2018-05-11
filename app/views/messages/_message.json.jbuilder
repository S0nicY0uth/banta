json.extract! message, :id, :content, :created_at, :updated_at
json.user_name message.user.name
json.user_id message.user.id
