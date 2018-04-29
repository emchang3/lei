puts "\tController: Index"

class IndexController < Sinatra::Base
    
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        content = [
            "#{$index_root}/above-fold.md",
            "#{$index_root}/lei.md",
            "#{$index_root}/internals.md"
        ]
    
        slim :index, locals: {
            content: $cUtils.parse_md(content),
            style: $cUtils.load_css("index"),
            title: "靁 - léi",
            url: request.url
        }
    end

    not_found do
        slim :not_found, locals: { **$cUtils.nf_404, url: request.url }
    end
    
end