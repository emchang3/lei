puts "\tController: Content"

class ContentController < Sinatra::Base

    require "#{$root}/helpers/content_helpers"
    
    set :public_folder, $assets_root
    set :views, $views

    get "/" do
        content = get_content("")
        redirect 404 if content.length == 0

        url = request.url

        time_sort(content)
        contentParts = page_slice(content, params, url)

        slim :content, locals: {
            **contentParts,
            style: $utils.load_css("content"),
            title: "Content",
            url: url
        }
    end

    get "/post/:title" do
        title = params["title"]
        redirect 404 if title.nil? || title.length == 0

        content = get_content(title)
        redirect 404 if content.length != 1

        parsed_title = title.split("-").join(" ")

        slim :post, locals: {
            content: $utils.parse_md(content)[0],
            style: $utils.load_css("content"),
            title: parsed_title,
            url: request.url
        }
    end

    get "/filter" do
        content = get_content("")

        filter_content(content, params)
        redirect 404 if content.length == 0

        url = request.url

        time_sort(content)
        contentParts = page_slice(content, params, url)

        slim :search_results, locals: {
            **contentParts,
            style: $utils.load_css("content"),
            title: "Filtered Results",
            url: url
        }
    end

    not_found do
        slim :not_found, locals: { **$utils.nf_404, url: request.url }
    end
end