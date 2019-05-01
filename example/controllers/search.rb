puts "\tController: Search"

class SearchController < Sinatra::Base

    set :content_dir, "#{$root}/{#{ContentHelpers.get_content_dirs.join(",")}}"
    set :stylesheet, "search"
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        url = request.url

        slim :search, locals: {
            style: ContentHelpers.load_css(settings.stylesheet),
            title: "Search",
            url: url
        }
    end

    post "/query" do
        redirect ContentHelpers.get_searchdest(params)
    end

    get "/results" do
        content = ContentHelpers.get_content(settings.content_dir)

        ContentHelpers.filter_content(content, params)
        redirect 404 if content.length == 0

        url = request.url

        ContentHelpers.time_sort(content)
        contentParts = ContentHelpers.paginate(content, params, url)

        slim :search_results, locals: {
            **contentParts,
            style: ContentHelpers.load_css("#{settings.stylesheet}_results"),
            title: "Filtered Results",
            url: url
        }
    end

    not_found do
        slim :notfound, locals: { **ContentHelpers.nf_404, url: request.url }
    end

end
