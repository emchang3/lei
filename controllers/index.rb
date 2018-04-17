puts "\tController: Index"

class IndexController < Sinatra::Base

    require "#{$root}/helpers/index_helpers"
    
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        slim :index, locals: index_locals
    end

    not_found do
        slim :not_found, locals: $utils.nf_404
    end
end