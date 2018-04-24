puts "\tController: Content"

class ContentController < Sinatra::Base

    require "#{$root}/helpers/content_helpers"
    
    set :public_folder, $assets_root
    set :views, $views

    get "/post/:title" do
        title = params["title"]
        redirect 404 if title.nil? || title.length == 0

        cl = get_content(title)
        redirect 404 if cl.length != 1

        slim :content, locals: {
            title: title,
            content: $utils.parse_md(cl)[0],
            style: $utils.load_css("content"),
            url: request.url
        }
    end

    get "/filterbydate" do
        cl = date_filter(params)
        redirect 404 if cl.length == 0

        cl = time_sort(cl)

        contentParts = page_slice(cl, params)

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