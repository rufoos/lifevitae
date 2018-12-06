Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin,
    Rails.application.credentials.env.linkedin[:app_id],
    Rails.application.credentials.env.linkedin[:app_secret],
    scope: 'r_basicprofile r_emailaddress'
end
