class MessageMailer < ActionMailer::Base
  default :from => "siteweb@alvarocanovas.com"

  def email_alvaro(message)
    @message = message
    
    mail :to => User.find_by_name('alvaro'),
         :subject => "Un visiteur vous adresse un email depuis le site web"
              
  end
end
