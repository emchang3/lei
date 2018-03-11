require "sinatra"

require "rack/deflater"
require "rack/protection"

require "slim"

$root = File.dirname(__FILE__)

configure do
    use Rack::Deflater
    use Rack::Protection, :except => [ :remote_token, :session_hijacking ]
    
    set :server, :puma
    set :bind, "0.0.0.0"
end

require "#{$root}/helpers/load_settings"

require "#{$root}/helpers/load_controllers"

load_controllers

map("/") { run ApplicationController }