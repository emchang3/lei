require "redcarpet"

$carpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

<<~parse_md
    This function reads the contents of a Markdown file and utilizes the
    Redcarpet gem to parse its contents into HTML, returning that markup as a
    string.
parse_md

def parse_md(filename)
    content = `cat #{$content_root}/#{filename}.md`
    $carpet.render(content)
end