# frozen_string_literal: true

module Seeds
  class Users < Seeds::Base
    USERS_COUNT = 10_000

    def generate!
      User.import(array_of_attributes(USERS_COUNT), validate: false)
    end

    private

    def klass_attributes
      mutex.synchronize do
        {
          first_name: FFaker::Name.first_name,
          last_name: FFaker::Name.last_name,
          email: "#{Thread.current.object_id}#{FFaker::Internet.unique.email}",
          encrypted_password: password_digest,
          created_at: Time.now,
          updated_at: Time.now,
          confirmed_at: Time.now
        }
      end
    end

    def password_digest
      @password_digest ||= Devise::Encryptor.digest(User, 'defaultpassword')
    end
  end
end
