json.array!(@logs) do |log|
  json.extract! log, :id, :title, :controller, :action, :user_id
  json.url log_url(log, format: :json)
end
