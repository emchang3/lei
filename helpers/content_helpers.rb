puts "\t--- Helpers: Content ---"

require "yaml"

def date_filter(params)
    content = get_content("")

    year = params["year"]
    return [] if !(content.length > 0) || year.nil? || year.length != 4

    content.reject! { |c| File::Stat.new(c).mtime.year != year.to_i }

    month = params["month"]
    return content if !(content.length > 0) || month.nil? || month.length != 2

    content.reject! { |c| File::Stat.new(c).mtime.month != month.to_i }

    day = params["day"]
    return content if !(content.length > 0) || day.nil? || day.length != 2

    content.reject! { |c| File::Stat.new(c).mtime.day != day.to_i }

    return content
end

def page_slice(content, params)
    pageParam = params["page"].to_i
    page = pageParam != 0 ? pageParam : 1
    pages = (content.length / 5.0).ceil
    firstIndex = (page - 1) * 5
    lastIndex = page * 5 - 1

    {
        content: $utils.parse_md(content[firstIndex..lastIndex]),
        page: page,
        pages: pages
    }
end

def time_sort(content)
    content.sort_by! { |c| File::Stat.new(c).mtime }
    content.reverse
end

def get_content(title)
    all = Dir.glob("#{$content_root}/*#{title}.md")
    classified = YAML.load_file($banlist)

    all - classified
end