class User < ApplicationRecord
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
      # return "define_email@on_your.model"
      Email notifications are now enabled
      email
      #if false
      #return nil
    end
end
