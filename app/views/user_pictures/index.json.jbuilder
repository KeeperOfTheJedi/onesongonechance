json.array!(@user_pictures) do |user_picture|
  json.extract! user_picture, :id
  json.url user_picture_url(user_picture, format: :json)
end
