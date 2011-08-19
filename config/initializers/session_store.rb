# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_walia_contacts_session',
  :secret      => 'f55c21ed05eb411d855cff495ae13645997467d149b75444f92198fc05831fa2fa57c35807f135a03dcfd0ddf4202093b8930793df23ec793bb142cadfb0558f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
