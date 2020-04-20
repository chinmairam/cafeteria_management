class User < ActiveRecord::Base
    validates :id, :name,  presence: true
    has_secure_password
end
