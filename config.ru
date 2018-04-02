require "sinatra"

require "rack/deflater"
require "rack/protection"

require "slim"

configure do
    use Rack::Deflater
    use Rack::Protection, :except => [ :remote_token, :session_hijacking ]
    
    set :server, :puma
    set :bind, "0.0.0.0"
end

# Global Path Values

$root = File.dirname(__FILE__)
$content_root = "#{$root}/content"
$style_root = "#{$root}/static/styles"

# Pulling in Helper Methods

require "#{$root}/helpers/settings_loader"
require "#{$root}/helpers/controller_loader"
require "#{$root}/helpers/css_loader"
require "#{$root}/helpers/md_parser"

load_controllers

map("/") { run ApplicationController }