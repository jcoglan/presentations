require 'rubygems'
require 'bundler/setup'
require 'parade'
require 'showoff'

$dir    = File.expand_path('..', __FILE__)
$decks  = {}
$static = Rack::File.new(File.join($dir, 'public'))

def deck_app(name)
  $decks[name] ||= begin
    deck_dir = File.join($dir, 'slides', name)
    if File.file?(File.join(deck_dir, 'parade'))
      app = Class.new(Parade::Server)
      app.presentation_directory = deck_dir
    else
      app = Class.new(ShowOff)
      app.pres_dir = deck_dir
      app.encoding = 'UTF-8'
    end
    app
  end
end

app = lambda do |env|
  env['PATH_INFO'] = '/index.html' if env['PATH_INFO'] == '/'

  path  = env['PATH_INFO']
  parts = path.split('/', -1).delete_if { |s| s == '' }
  deck  = parts.shift
  
  if Dir.entries(File.join($dir, 'slides')).include?(deck)
    env['SCRIPT_NAME'] = "/#{deck}"
    env['PATH_INFO'] = ([''] + parts).join('/')
    deck_app(deck).call(env)
  
  else
    $static.call(env)
  end
end

run app

