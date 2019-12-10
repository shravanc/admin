class AbstractHandler < Handler
  attr_writer :next_handler

#This method is caled while resgistering the responsibility and will set the instance variable @next_handler to next responsibility class.
  def next_handler(handler)
    @next_handler = handler
    retun handler
  end

  #this function will be called when any rensponsibility failed to serve the request.
  def handle 
    return @next_handler.handle(request) if @next_handler

    nil
  end

end
