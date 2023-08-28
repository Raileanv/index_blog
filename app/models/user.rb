class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :api

  def send_devise_notification(notification, *args)
    if notification == :confirmation_instructions
      devise_mailer.send(notification, self, *args).deliver_later(wait: 5.seconds)
    else
      super
    end
  end
end
