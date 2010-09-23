class Notifier < ActionMailer::Base
  default_url_options[:host] = WEB_HOST

  # Sent when a user requests a password reset.
  # Contains the link they follow back to the site with their token
  # so they can reset the password
  def password_reset_instructions(user)
    subject       "#{Settings.app_name} Password Reset Instructions"
    from          "#{Settings.app_name} <noreply@#{WEB_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  # Sent when a user first signs up
  # Contains a link back to the site which verifies the email
  # and then allows the user to set their password
  def activation_instructions(user)
    subject       "Please activate your #{Settings.app_name} account"
    from          "#{Settings.app_name} <noreply@#{WEB_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  # Sent when a user's account activation is completed.
  def activation_confirmation(user)
    subject       "#{Settings.app_name} Activation complete"
    from          "#{Settings.app_name} <noreply@#{WEB_HOST}>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end


end
