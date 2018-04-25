require "dotenv"
require "redcarpet"

class GlobalUtils
    def initialize
        Dotenv.load
        self.declare_globals

        @carpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new({
            hard_wrap: true,
            highlight: true
        }))
    end

    def declare_globals
        puts "--- Declaring Globals ---"
        
        $assets_root = "#{$root}/static"
        $content_root = "#{$root}/content"
        $index_root = "#{$root}/index"
        $style_root = "#{$assets_root}/styles"
        $views = "#{$root}/views"

        $banlist = "#{$root}/banlist.yml"

        <<~AMP
            AMP Static Header Parts, as of 15 APR 2018:
            https://www.ampproject.org/docs/fundamentals/spec

            AMP Boilerplate, as of 15 APR 2018:
            https://www.ampproject.org/docs/fundamentals/spec/amp-boilerplate

            amp-bind, as of 15 APR 2018:
            https://www.ampproject.org/docs/reference/components/amp-bind
        AMP

        $amp_static_header = <<~HEADER
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
            <script async src="https://cdn.ampproject.org/v0.js"></script>
        HEADER

        $amp_boiler = <<~BOILER
            <style amp-boilerplate>body{-webkit-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-moz-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-ms-animation:-amp-start 8s steps(1,end) 0s 1 normal both;animation:-amp-start 8s steps(1,end) 0s 1 normal both}@-webkit-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-moz-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-ms-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-o-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}</style><noscript><style amp-boilerplate>body{-webkit-animation:none;-moz-animation:none;-ms-animation:none;animation:none}</style></noscript>
        BOILER

        $amp_bind = "<script async custom-element=\"amp-bind\" src=\"https://cdn.ampproject.org/v0/amp-bind-0.1.js\"></script>"
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

    def nf_404
        {
            title: "404: Not Found",
            style: self.load_css("notfound")
        }
    end
end