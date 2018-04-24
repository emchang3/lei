puts "\t--- Helpers: Content ---"

require "yaml"

def date_filter(params)
    cl = get_content("")

    year = params["year"]
    return [] if !(cl.length > 0) || year.nil? || year.length != 4

    cl.reject! { |c| File::Stat.new(c).mtime.year != year.to_i }

    month = params["month"]
    return cl if !(cl.length > 0) || month.nil? || month.length != 2

    cl.reject! { |c| File::Stat.new(c).mtime.month != month.to_i }

    day = params["day"]
    return cl if !(cl.length > 0) || day.nil? || day.length != 2

    cl.reject! { |c| File::Stat.new(c).mtime.day != day.to_i }

    return cl
end

def page_slice(cl, params)
    pageParam = params["page"].to_i
    page = pageParam != 0 ? pageParam : 1
    pages = (cl.length / 5.0).ceil
    firstIndex = (page - 1) * 5
    lastIndex = page * 5 - 1

    puts "--- firstIndex: #{firstIndex}"
    puts "--- lastIndex: #{lastIndex}"

    {
        contentList: $utils.parse_md(cl[firstIndex..lastIndex]),
        page: page,
        pages: pages
    }
end

def time_sort(cl)
    cl.sort_by! { |c| File::Stat.new(c).mtime }
    cl.reverse
end

def get_content(title)
    all = Dir.glob("#{$content_root}/*#{title}.md")
    classified = YAML.load_file($banlist)

    all - classified
end