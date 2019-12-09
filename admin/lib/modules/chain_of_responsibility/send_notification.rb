class SendNotification < AbstractHandler

def handle request
  if request == "notify"
    puts "notified"
  else
    super(request)
  end
end

end
