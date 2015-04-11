class UserMailer < ApplicationMailer
  default from: 'notifications@andrewjohngarcia.com'
   
    def welcome_email(user, message, usersemail)
      @user = user
      @message = message
      @usersemail = usersemail
      mail(to: "drewgarcia23@gmail.com", subject: 'Email from My Site')
    end
end
