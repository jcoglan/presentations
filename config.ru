require File.expand_path('../vendor/showoff/lib/showoff', __FILE__)
dir = File.expand_path('..', __FILE__)

Dir.entries(dir + '/slides').each do |presentation|
  map '/' + presentation do
    app = Class.new(ShowOff)
    app.pres_dir = dir + '/slides/' + presentation
    run app
  end
end

app = lambda do |env|
  path = env['PATH_INFO']
  path = '/index.html' if path == '/'
  full_path = dir + '/public' + path
  
  if path !~ /\.\./ and File.file?(full_path)
    [200, {'Content-Type' => 'text/html'}, File.new(full_path)]
  else
    [404, {'Content-Type' => 'text/plain'}, ['Not found']]
  end
end

map '/' do
  run app
end
