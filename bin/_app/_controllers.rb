require_relative "../functions"

content = <<~CONTENT
    puts "\\tController: Content"

    class ContentController < Sinatra::Base
        
        set :content_dir, "\#{$root}/content"
        set :stylesheet, "content"
        set :public_folder, $assets_root
        set :views, $views

        get "/" do
            content = ContentHelpers.get_content(settings.content_dir)
            redirect 404 if content.length == 0

            url = request.url

            ContentHelpers.time_sort(content)
            contentParts = ContentHelpers.paginate(content, params, url)

            slim :content, locals: {
                **contentParts,
                style: ContentHelpers.load_css(settings.stylesheet),
                title: "Posts",
                url: url
            }
        end

        get "/post/:title" do
            title = params["title"]
            redirect 404 if title.nil? || title.length == 0

            content = ContentHelpers.get_post(settings.content_dir, title)
            redirect 404 if content.length != 1

            parsed_title = title.split("-").join(" ")

            slim :post, locals: {
                content: ContentHelpers.parse_md(content)[0],
                style: ContentHelpers.load_css(settings.stylesheet),
                title: parsed_title,
                url: request.url
            }
        end

        get "/filter" do
            content = ContentHelpers.get_content(settings.content_dir)

            ContentHelpers.filter_content(content, params)
            redirect 404 if content.length == 0

            url = request.url

            ContentHelpers.time_sort(content)
            contentParts = ContentHelpers.paginate(content, params, url)

            slim :search_results, locals: {
                **contentParts,
                style: ContentHelpers.load_css(settings.stylesheet),
                title: "Filtered Results",
                url: url
            }
        end

        not_found do
            slim :notfound, locals: { **ContentHelpers.nf_404, url: request.url }
        end

    end
CONTENT

custom = <<~CUSTOM
    puts "\\tController: Custom"

    class CustomController < Sinatra::Base
        
        set :public_folder, $assets_root
        set :views, $views

        routes = YAML.load_file("\#{$root}/customlist.yml")

        routes.each do |route|
            name = route["name"]
            path = route["path"]
            puts "\\t\\t\#{path}: \#{name}"

            get path do
                folder = "\#{$root}/\#{name}"

                content = route["content"].map { |section| "\#{folder}/\#{section}" }

                slim name.to_sym, locals: {
                    content: ContentHelpers.parse_md(content),
                    style: ContentHelpers.load_css(name),
                    title: route["title"],
                    url: request.url
                }
            end
        end

        not_found do
            slim :notfound, locals: { **ContentHelpers.nf_404, url: request.url }
        end

    end
CUSTOM

files = {
    "content.rb": content,
    "custom.rb": custom
}

loc = "$(pwd)/controllers"

makeFiles(files, loc)