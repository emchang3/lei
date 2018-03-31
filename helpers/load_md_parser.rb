require "redcarpet"

$carpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

def md_parse(filename)
    content = `cat #{$content_root}/#{filename}.md`
    $carpet.render(content)
end