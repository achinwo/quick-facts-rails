class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@quickfacts.com"
  layout 'mailer'
end
