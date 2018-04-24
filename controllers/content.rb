puts "\tController: Content"

class ContentController < Sinatra::Base

    require "#{$root}/helpers/content_helpers"
    
    set :public_folder, $assets_root
    set :views, $views

    get "/post/:title" do
        title = params["title"]
        redirect 404 if title.nil? || title.length == 0

        content = get_content(title)
        redirect 404 if content.length != 1

        slim :content, locals: {
            title: title,
            content: $utils.parse_md(content)[0],
            style: $utils.load_css("content"),
            url: request.url
        }
    end

    get "/filterbydate" do
        content = date_filter(params)
        redirect 404 if content.length == 0

        content = time_sort(content)

        contentParts = page_slice(content, params)

        slim :content_many, locals: {
            **contentParts,
            title: "Filtered Results",
            style: $utils.load_css("content"),
            url: request.url
        }
    end

    not_found do
        slim :not_found, locals: { **$utils.nf_404, url: request.url }
    end
end