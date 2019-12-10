class EncryptPassword < AbstractHandler

#If the handler cannot handle the request or if it is not its request to serve, it passes the control to parent and then parent 
#passes the control to the respective responsibilty class in the order of how the responsibility are registered.
def handle()
  if request == "encrypt"
    put "encrypted"
  else
    super(request)
  end

end

end
