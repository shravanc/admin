class Handler

def next_handler=(handler)
  raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
end

def handle(request)
  raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
end

end
