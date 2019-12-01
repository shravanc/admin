class SendNotification < AbstractHandler

def handle request
  if request == "notify"
  else
    super(request)
  end
end

end
