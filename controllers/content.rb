puts "\tController: Content"

class ContentController < Sinatra::Base
    
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        content = $cUtils.get_content
        redirect 404 if content.length == 0

        url = request.url

        $cUtils.time_sort(content)
        contentParts = $cUtils.paginate(content, params, url)

        slim :content, locals: {
            **contentParts,
            style: $cUtils.load_css("content"),
            title: "Posts",
            url: url
        }
    end

    get "/post/:title" do
        title = params["title"]
        redirect 404 if title.nil? || title.length == 0

        content = $cUtils.get_post(title)
        redirect 404 if content.length != 1

        parsed_title = title.split("-").join(" ")

        slim :post, locals: {
            content: $cUtils.parse_md(content)[0],
            style: $cUtils.load_css("content"),
            title: parsed_title,
            url: request.url
        }
    end

    get "/filter" do
        content = $cUtils.get_content

        $cUtils.filter_content(content, params)
        redirect 404 if content.length == 0

        url = request.url

        $cUtils.time_sort(content)
        contentParts = $cUtils.paginate(content, params, url)

        slim :search_results, locals: {
            **contentParts,
            style: $cUtils.load_css("content"),
            title: "Filtered Results",
            url: url
        }
    end

    not_found do
        slim :not_found, locals: { **$cUtils.nf_404, url: request.url }
    end
end