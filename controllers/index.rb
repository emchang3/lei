puts "\tController: Index"

class IndexController < Sinatra::Base

    require "#{$root}/helpers/index_helpers"
    
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        slim :index, locals: index_locals
    end

    not_found do
        404
    end
end