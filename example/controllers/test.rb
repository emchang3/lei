require "#{$root}/controllers/content"

puts "\tController: Test"

class TestController < ContentController
    
    set :content_dir, "#{$root}/test"
    set :stylesheet, "content"
    set :public_folder, $assets_root
    set :views, $views

end