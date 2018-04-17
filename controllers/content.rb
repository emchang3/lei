puts "\tController: Content"

class ContentController < Sinatra::Base

    require "#{$root}/helpers/content_helpers"
    
    set :public_folder, $assets_root
    set :views, $views

    get "/post/:title" do
        title = params["title"]
        redirect 404 if title.nil? || title.length < 1

        contentList = Dir.glob("#{$content_root}/*_#{title}.md")
        redirect 404 if contentList.length != 1

        contentList = eject_banned(contentList)
        redirect 404 if contentList.length == 0

        slim :content, locals: {
            title: title,
            content: $utils.parse_md(contentList)[0],
            style: $utils.load_css("content")
        }
    end

    get "/filterbydate" do
        year = params["year"]

        # Future: Create a page with a form for date input and redirect to that.
        redirect 404 if year.nil? || year.length != 4

        globString = "#{$content_root}/#{year}-"
        titleString = year

        month = params["month"]
        if !month.nil? && month.length == 2
            globString += "#{month}-"
            titleString = "#{Date::ABBR_MONTHNAMES[month.to_i]} #{titleString}"
        end

        day = params["day"]
        if !day.nil? && day.length == 2
            globString += "#{day}_"
            titleString = "#{day} #{titleString}"
        end

        globString += "*.md"

        contentList = Dir.glob(globString)
        redirect 404 if contentList.length == 0

        contentList = eject_banned(contentList)
        redirect 404 if contentList.length == 0

        contentList.sort!.reverse!

        pageParam = params["page"].to_i
        
        contentParts = page_slice(contentList, pageParam)
        contentList = contentParts[:contentList]
        page = contentParts[:page]
        pages = contentParts[:pages]

        slim :content_many, locals: {
            title: titleString,
            contentList: $utils.parse_md(contentList),
            page: page,
            pages: pages,
            style: $utils.load_css("content")
        }
    end

    not_found do
        slim :not_found, locals: $utils.nf_404
    end
end