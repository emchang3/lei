require "sinatra"
require "slim"
require "rack/deflater"
require "rack/protection"

# Project Root

$root = File.dirname(__FILE__)

# Global Settings and Utilities

require "#{$root}/helpers/global_utils"
$utils = GlobalUtils.new

# Sinatra Configuration

configure do
    use Rack::Deflater
    use Rack::Protection, except: [ :remote_token, :session_hijacking ]
    
    set :server, :puma
    set :bind, "0.0.0.0"
end

puts "--- Loading Controllers ---"
    
Dir.glob("#{$root}/controllers/*.rb") do |controller|
    require controller
end

map("/") { run IndexController }
map("/content") { run ContentController }