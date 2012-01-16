module EmailController

def process_request(env)
  request = Rack::Request.new(env)
  if request.post?
    p request.params["email"]
    Email.create! :email => request.params["email"] rescue  return "Email Format Error!"
    File.read("views/success.html")
  else
    "invalide request!"
  end
end

end
