require "dotenv"

module GlobalUtils
    def self.declare_globals
        puts "--- Loading Environment Variables ---"

        Dotenv.load

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
    
end