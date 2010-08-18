class MessageMailer < ActionMailer::Base
  default :from => "siteweb@alvarocanovas.com", :to => %w{nicolas@w3bflows.com camillegarnier@me.com}

  def email_alvaro(message)
    @message = message
    attachments.inline['cam.png'] = File.read(File.join(Rails.root,'public/images/cam.png'))   
    mail :subject => "Un visiteur vous adresse un email depuis le site web" #, :to => User.find_by_name('alvaro'),
              
  end
end
