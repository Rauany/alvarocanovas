class MessageMailer < ActionMailer::Base
  default :from => "siteweb@alvarocanovas.com", :to => 'nicolas@w3bflows.com'

  def email_alvaro(message)
    @message = message
    
    mail :subject => "Un visiteur vous adresse un email depuis le site web" #, :to => User.find_by_name('alvaro'),
              
  end
end
