class JwtBlacklist < ActiveRecord::Base
  self.table_name = 'jwt_blacklist'
  include Devise::JWT::RevocationStrategies::Blacklist
end
