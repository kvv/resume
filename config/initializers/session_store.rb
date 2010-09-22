# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_resume_session',
  :secret      => '42737a754b6a5776d78d8de17c3eb984e5f9be1c4ad51637920a22ff4c645652769354a433209c14189f73fd70cb75ed3cbb12d9079c6a4b49deb827de609c9e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
