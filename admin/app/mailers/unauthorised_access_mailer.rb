class UnauthorisedAccessMailer < ApplicationMailer

def report
  email = "shravan.chandrashekharaiah@gmail.com"
  mail(to: email, subject: "Caution, Unauthorised Action!!!")
end

end
