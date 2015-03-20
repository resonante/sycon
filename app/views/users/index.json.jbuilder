json.array!(@users) do |user|
  json.extract! user, :id, :email
  json.role user.roles.first
  json.url user_url(user, format: :json)
end
