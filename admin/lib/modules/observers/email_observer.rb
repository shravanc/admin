class EmailObserver < Observer

def update
  UnauthorisedAccessMailer.report().deliver_now
end

end
