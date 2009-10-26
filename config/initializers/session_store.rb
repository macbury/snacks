# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_snacks_session',
  :secret      => 'de4e0fd4aca7ba4ee2d6503522ccc0352b8d1a511c705d9d39123b80c543bc819b40b698702d85b71eb41e455b05892a0d6096a536bff1b10caff3ed479b874c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
