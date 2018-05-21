puts "\tController: Custom"

class CustomController < Sinatra::Base
    
    set :public_folder, $assets_root
    set :views, $views

    routes = YAML.load_file("#{$root}/customlist.yml")

    routes.each do |route|
        name = route["name"]
        path = route["path"]
        puts "\t\t#{path}: #{name}"

        get path do
            folder = "#{$root}/#{name}"

            content = route["content"].map { |section| "#{folder}/#{section}" }

            slim name.to_sym, locals: {
                content: ContentHelpers.parse_md(content),
                style: ContentHelpers.load_css(name),
                title: route["title"],
                url: request.url
            }
        end
    end

    not_found do
        slim :not_found, locals: { **ContentHelpers.nf_404, url: request.url }
    end

end