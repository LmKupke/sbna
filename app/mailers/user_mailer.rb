class UserMailer < ApplicationMailer
  def new_registration(user)
    @user = user
    mail(:to => @user.email, :subject => "Thank you for registering with SBNA")
  end
end
