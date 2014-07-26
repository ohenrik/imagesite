json.array!(@messages) do |message|
  json.extract! message, :subject, :content, :sender_email, :sender_name, :sender_id, :sender_type, :receiver_id, :receiver_type, :message_type
  json.url message_url(message, format: :json)
end
