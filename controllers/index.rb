puts "\tController: Index"

class IndexController < Sinatra::Base
    
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        index = "#{$root}/index"

        content = [
            "#{index}/above-fold.md",
            "#{index}/lei.md",
            "#{index}/internals.md"
        ]
    
        slim :index, locals: {
            content: ContentHelpers.parse_md(content),
            style: ContentHelpers.load_css("index"),
            title: "靁 - léi",
            url: request.url
        }
    end

    not_found do
        slim :not_found, locals: { **ContentHelpers.nf_404, url: request.url }
    end
    
end