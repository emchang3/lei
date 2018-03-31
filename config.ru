require "sinatra"

require "rack/deflater"
require "rack/protection"

require "slim"

$root = File.dirname(__FILE__)
$content_root = "#{$root}/content"

configure do
    use Rack::Deflater
    use Rack::Protection, :except => [ :remote_token, :session_hijacking ]
    
    set :server, :puma
    set :bind, "0.0.0.0"
end

require "#{$root}/helpers/load_settings"
require "#{$root}/helpers/load_controllers"
require "#{$root}/helpers/load_md_parser"

load_controllers

map("/") { run ApplicationController }