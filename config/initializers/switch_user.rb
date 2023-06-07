SwitchUser.setup do |config|
  config.provider = :devise
  config.available_users = { user: -> { User.all } }
  config.available_users_identifiers = { user: :id }
  config.available_users_names = { user: :email }
  config.controller_guard = ->(current_user, request) { true }
  config.view_guard = ->(current_user, request) { true }
  config.redirect_path = ->(request, params) { '/' }
  config.helper_with_guest = true
end
