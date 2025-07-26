class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    mail(to: "admin@example.com", subject: "【お問い合わせ】#{@contact.subject}")
  end
end