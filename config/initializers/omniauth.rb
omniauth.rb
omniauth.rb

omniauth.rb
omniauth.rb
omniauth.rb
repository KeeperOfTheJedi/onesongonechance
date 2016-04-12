OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
  :scope => 'email,user_friends,user_actions.music,user_location,user_photos,user_relationships,user_relationship_details'
end