json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :email, :avatar_path, :memo, :signatures, :point, :reg_date, :login_date
  json.url user_url(user, format: :json)
end
