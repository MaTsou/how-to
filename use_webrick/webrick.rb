require 'webrick'

def attributes(query_string)
  return "no attributes" unless query_string
  query_string.split('&').to_h { _1.split('=') }
end

def post_params(req)
  req.query.transform_keys(&:to_sym)
end

server = WEBrick::HTTPServer.new :Port => 8000
server.mount_proc '/' do |req, res|
  res.content_type = 'text/html'
  res.body =<<~HTML
  <form method="POST" action="http://localhost:8000/hello">
  <input type="text" name="name">
  <button type="submit">SUBMIT</button>
  </form>
  HTML
end

server.mount_proc '/hello' do |req, res|
  res.content_type = 'text/html'
  res.body = case req.request_method.upcase
  when 'POST'
    <<~HTML
    Hello, #{post_params(req)[:name]}
    HTML
  when 'GET'
    <<~HTML
    Hello, this was a GET request
    HTML
  else
    "Unsupported request method !"
  end
end

# Hey, 'INT' means interruption event !!
trap('INT') { server.stop } # stop server with Ctrl-C
server.start

