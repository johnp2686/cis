class UserMailer < ActionMailer::Base
  default from: "test@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end

  def user_send_mail(to,subject,message,from)
  	@subject = subject
    @recipients = to
    @body = message
    @from = "test@gmail.com"
    mail(:from => @from, :to => @recipients , :subject => @subject)
  end	
  
  def agent_status_mail(mail_id,sub,editor)
    @mail_id = mail_id
    @sub=sub
    @editor=editor

    mail(:to =>  @mail_id, :subject => @sub)
  end  
  
  def sent_quotation(from,to,subject,message,quote)
    @from= from
    @to=to
    @subject=subject
    @message=message
    attachments["Quotation.pdf"] = File.read("#{Rails.root.to_s}/public"+"#{quote.quotation}") #File.read(file_path)
    mail(:to => @to, :subject => @subject) 
  end
end
