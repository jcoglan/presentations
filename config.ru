require File.expand_path('../vendor/showoff/lib/showoff', __FILE__)

$dir   = File.expand_path('..', __FILE__)
$decks = {}

def deck(name)
  $decks[name] ||= begin
    app = Class.new(ShowOff)
    app.pres_dir = File.join($dir, 'slides', name)
    app.encoding = 'UTF-8'
    app
  end
end

app = lambda do |env|
  path = env['PATH_INFO']
  path = '/index.html' if path == '/'
  full_path = File.join($dir, 'public', path)
  deck_name = path.scan(/[^\/]+/).delete_if { |s| s == '' }.first
  
  if path !~ /\.\./ and File.file?(full_path)
    [200, {'Content-Type' => 'text/html'}, File.new(full_path)]
  
  elsif Dir.entries(File.join($dir, 'slides')).include?(deck_name)
    env['SCRIPT_NAME'] = "/#{deck_name}"
    env['PATH_INFO'] = env['PATH_INFO'].gsub(%r{^\/#{deck_name}}, '')
    deck(deck_name).call(env)
  
  else
    [404, {'Content-Type' => 'text/plain'}, ['Not found']]
  end
end

run app

