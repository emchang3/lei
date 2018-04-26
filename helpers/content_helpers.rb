puts "\t--- Helpers: Content ---"

require "yaml"

def filter_content(content, params)
    term = params["term"]
    if !term.nil? && term.length > 2
        content.reject! do |c|
            post = `cat #{c}`
            !post.match?(Regexp.new(term, true))
        end
    end

    yyyy = params["year"]
    if !yyyy.nil? && yyyy.length == 4
        content.reject! { |c| File::Stat.new(c).mtime.year != yyyy.to_i }
    end

    mm = params["month"]
    if !mm.nil? && mm.length == 2
        content.reject! { |c| File::Stat.new(c).mtime.month != mm.to_i }
    end

    dd = params["day"]
    if !dd.nil? && dd.length == 2
        content.reject! { |c| File::Stat.new(c).mtime.day != dd.to_i }
    end
end

def get_content(title)
    all = Dir.glob("#{$content_root}/*#{title}.md")
    classified = YAML.load_file($banlist)

    all - classified
end

def page_slice(content, params, url)
    pageParam = params["page"].to_i

    page = pageParam != 0 ? pageParam : 1
    pages = (content.length / 5.0).ceil
    
    firstIndex = (page - 1) * 5
    lastIndex = page * 5 - 1

    path = URI(url).path
    pageUrls = [ nil, nil, nil, nil ]
    
    if page > 1
        firstParams = params.clone
        firstParams["page"] = "1"
        encodedFirst = URI.encode_www_form(firstParams)
        pageUrls[0] = "#{path}?#{encodedFirst}"

        prevParams = params.clone
        prevParams["page"] = (page - 1).to_s
        encodedPrev = URI.encode_www_form(prevParams)
        pageUrls[1] = "#{path}?#{encodedPrev}"
    end

    if page < pages
        nextParams = params.clone
        nextParams["page"] = (page + 1).to_s
        encodedNext = URI.encode_www_form(nextParams)
        pageUrls[2] = "#{path}?#{encodedNext}"

        lastParams = params.clone
        lastParams["page"] = pages.to_s
        encodedLast = URI.encode_www_form(lastParams)
        pageUrls[3] = "#{path}?#{encodedLast}"
    end

    {
        content: $utils.parse_md(content[firstIndex..lastIndex]),
        page: page,
        pages: pages,
        pageUrls: pageUrls
    }
end

def time_sort(content)
    content.sort_by! { |c| File::Stat.new(c).mtime }
    content.reverse!
end