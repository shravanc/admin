class UnauthorisedAccesss < Subject
attr_accessor :state

def initialize req=nil, par=nil
  @request = req
  @params  = par
  @observers = []
end

def attach observer
  @observers << observer
end

def detach observer
  @observers.delete(observer)
end

def notify
  @observers.each { |observer| observer.update }
end

def alaram_operation action
  @state = action
  notify
end

end

