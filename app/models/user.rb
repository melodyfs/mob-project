class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # before_action :authenticate_user!
  # user_signed_in?

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
    acts_as_messageable
    #Returning any kind of identification you want for the model
    def name
      return "You should add method :name in your Messageable model"
    end

    #Returning the email address of the model if an email should be sent for this object (Message or Notification).
    #If no mail has to be sent, return nil.
    def mailboxer_email(object)

      #Check if an email should be sent for that object
      #if true
      return email
      #if false
      #return nil
    end
end
