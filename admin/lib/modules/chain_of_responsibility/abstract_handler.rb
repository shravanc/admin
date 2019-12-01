class AbstractHandler < Handler
  attr_writer :next_handler


  def next_handler(handler)
    @next_handler = handler
    handler
  end

  def handle 
    return @next_handler.handle(request) if @next_handler

    nil
  end

end
