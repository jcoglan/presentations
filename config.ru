require 'rubygems'
require 'bundler/setup'
require File.expand_path('../vendor/parade/lib/parade', __FILE__)

$dir    = File.expand_path('..', __FILE__)
$decks  = {}
$static = Rack::File.new(File.join($dir, 'public'))

def deck(name)
  $decks[name] ||= begin
    app = Class.new(Parade::Server)
    app.presentation_directory = File.join($dir, 'slides', name)
    app
  end
end

app = lambda do |env|
  env['PATH_INFO'] = '/index.html' if env['PATH_INFO'] == '/'
  path = env['PATH_INFO']
  deck_name = path.scan(/[^\/]+/).delete_if { |s| s == '' }.first
  
  if path !~ /\.\./ and File.file?(full_path)
    [200, {'Content-Type' => 'text/html'}, File.new(full_path)]

  elsif Dir.entries(File.join($dir, 'slides')).include?(deck_name)
    env['SCRIPT_NAME'] = "/#{deck_name}"
    env['PATH_INFO'] = env['PATH_INFO'].gsub(%r{^\/#{deck_name}}, '')
    deck(deck_name).call(env)
  else
    $static.call(env)
  end
end

run app
