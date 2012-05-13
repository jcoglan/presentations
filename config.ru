require File.expand_path('../vendor/showoff/lib/showoff', __FILE__)
dir = File.expand_path('..', __FILE__)

Dir.entries(dir).each do |presentation|
  map '/' + presentation do
    app = Class.new(ShowOff)
    app.pres_dir = dir + '/' + presentation
    run app
  end
end

app = lambda do |env|
  [200, {'Content-Type' => 'text/html'}, File.new(dir + '/index.html')]
end

map '/' do
  run app
end
