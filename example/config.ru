require "rack/deflater"
require "rack/protection"
require "sinatra"
require "slim"
require "yaml"

# Project Root

$root = File.dirname(__FILE__)

# Global Settings and Utilities

puts "--- Loading Helpers ---"

utils_root = "#{$root}/helpers"

require "#{utils_root}/global_utils"
GlobalUtils.declare_globals

require "#{utils_root}/content_helpers"

# Sinatra Configuration

configure do
    use Rack::Deflater
    use Rack::Protection, except: [ :remote_token, :session_hijacking ]
    
    set :server, :puma
    set :bind, "0.0.0.0"
end

puts "--- Loading Controllers ---"

controllers = YAML.load_file("#{$root}/controllerlist.yml")

controllers.each do |controller|
    require "#{$root}/controllers/#{controller["file"]}"
    
    map(controller["path"]) { run eval(controller["name"]) }
end
