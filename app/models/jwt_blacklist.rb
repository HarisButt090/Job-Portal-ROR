# app/models/jwt_blacklist.rb
class JwtBlacklist
    def self.on_revocation(payload)
      # logic for handling token revocation, e.g., saving tokens to a database or marking them as revoked.
    end
  
    def self.valid_payload(payload, user)
      true # add any custom checks for validity of the payload if needed.
    end
  end
  