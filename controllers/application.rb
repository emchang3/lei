puts "\tController: Application"

class ApplicationController < Sinatra::Base
    
    set :public_folder, "#{$root}/static"
    set :views, "#{$root}/views"

    get "/" do
        slim :index, locals: { foo: md_parse("hello_world") }
    end
end