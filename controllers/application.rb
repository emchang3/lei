puts "\tController: Application"

class ApplicationController < Sinatra::Base
    
    set :public_folder, "#{$root}/static"
    set :views, "#{$root}/views"

    get "/" do
        slim :index, locals: {
            content: parse_md("hello_world"),
            style: load_css("style")
        }
    end
end