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

#this will iterate over the list of observers and call update.
def notify
  @observers.each { |observer| observer.update }
end

#This functions triggers/notify all the observers that were attached.
def alaram_operation action
  @state = action
  notify
end

end

