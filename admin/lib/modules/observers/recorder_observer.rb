class RecorderObserver < Observer

def update
  return HTTParty.post(construct_url, :headers => construct_header, :body => construct_body.to_json)
end

private

def construct_body
  {"action"=> {"status"=>"401", "message"=> "unathorised access", "action" => state}}
end

def construct_url
  domain = "amazon.stream.com"
  host = "http://" + domain + ":3004/actions"
  host
end

def construct_header
  {'Content-Type'=>'application/json', 'Accept' => 'application/json'}
end

end
