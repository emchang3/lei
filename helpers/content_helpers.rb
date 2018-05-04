puts "\t--- Helpers: Content ---"

require "redcarpet"

module ContentHelpers

    CARPET = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new({
            hard_wrap: true,
            highlight: true
        })
    )

    def self.filter_content(content, params)
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
    
    def self.get_content(contentDir)
        all = Dir.glob("#{contentDir}/*.md")
        classified = YAML.load_file($banlist)
    
        all - classified
    end

    def self.get_post(contentDir, title)
        content = self.get_content(contentDir)

        post = "#{contentDir}/#{title}.md"

        content.include?(post) ? [ post ] : []
    end

    <<~load_css
        This function reads and returns the contents of a CSS file as a string.
        Its return value gets stored in a variable for ease of interpolation in
        templates.
    load_css

    def self.load_css(filename)
        `cat #{$style_root}/#{filename}.css`
    end

    def self.mp_eu(path, params, replacement)
        newParams = {}
        params.each { |k, v| newParams[k] = v }
        replacement.each { |i, j| newParams[i] = j }
        encoded = URI.encode_www_form(newParams)
        
        "#{path}?#{encoded}"
    end

    def self.nf_404
        {
            title: "404: Not Found",
            style: self.load_css("notfound")
        }
    end
    
    def self.paginate(content, params, url)
        pageParam = params["page"].to_i
    
        page = pageParam != 0 ? pageParam : 1
        pages = (content.length / 5.0).ceil
        
        firstIndex = (page - 1) * 5
        lastIndex = page * 5 - 1
    
        path = URI(url).path
        pageUrls = [ nil, nil, nil, nil ]
        
        if page > 1
            pageUrls[0] = self.mp_eu(path, params, { "page" => "1" })
            
            prev = (page - 1).to_s
            pageUrls[1] = self.mp_eu(path, params, { "page" => prev })
        end
    
        if page < pages
            foll = (page + 1).to_s
            pageUrls[2] = self.mp_eu(path, params, { "page" => foll })

            pageUrls[3] = self.mp_eu(path, params, { "page" => pages.to_s })
        end
    
        {
            content: self.parse_md(content[firstIndex..lastIndex]),
            page: page,
            pages: pages,
            pageUrls: pageUrls
        }
    end

    <<~parse_md
        This function takes a list of filenames, reads their contents, and
        utilizes the Redcarpet gem to parse them into HTML.
    parse_md

    def self.parse_md(filenames)
        filenames.map do |filename|
            content = `cat #{filename}`
            CARPET.render(content)
        end
    end
    
    def self.time_sort(content)
        content.sort_by! { |c| File::Stat.new(c).mtime }
        content.reverse!
    end

end