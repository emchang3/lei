puts "\t--- Helpers: Content ---"

require "redcarpet"

class ContentHelpers
    def initialize
        @carpet = Redcarpet::Markdown.new(
            Redcarpet::Render::HTML.new({
                hard_wrap: true,
                highlight: true
            })
        )
    end

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
    
    def get_content(contentDir)
        all = Dir.glob("#{contentDir}/*.md")
        classified = YAML.load_file($banlist)
    
        all - classified
    end

    def get_post(contentDir, title)
        content = self.get_content(contentDir)

        post = "#{contentDir}/#{title}.md"

        content.include?(post) ? [ post ] : []
    end

    def nf_404
        {
            title: "404: Not Found",
            style: self.load_css("notfound")
        }
    end
    
    def paginate(content, params, url)
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

    def parse_md(filenames)
        filenames.map do |filename|
            content = `cat #{filename}`
            @carpet.render(content)
        end
    end

    <<~load_css
        This function reads and returns the contents of a CSS file as a string.
        Its return value gets stored in a variable for ease of interpolation in
        templates.
    load_css

    def load_css(filename)
        `cat #{$style_root}/#{filename}.css`
    end
    
    def time_sort(content)
        content.sort_by! { |c| File::Stat.new(c).mtime }
        content.reverse!
    end
end