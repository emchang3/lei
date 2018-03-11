puts "\tController: Application"

class ApplicationController < Sinatra::Base
    
    set :public_folder, "#{$root}/static"
    set :views, "#{$root}/views"

    get "/" do
        slim :index, locals: { foo: "bar" }
    end
end