class EncryptPassword < AbstractHandler

def handle()
  if request == "encrypt"
    put "encrypted"
  else
    super(request)
  end

end

end
