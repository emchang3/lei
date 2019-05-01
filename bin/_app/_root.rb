require_relative "../functions"

banlist = <<~BANLIST
    ---
    # Paths of content from `$root`.

    - ./banned-content.md
    ...
BANLIST

config = <<~CONFIG
    require "rack/deflater"
    require "rack/protection"
    require "sinatra"
    require "slim"
    require "yaml"

    # Project Root

    $root = File.dirname(__FILE__)

    # Global Settings and Utilities

    puts "--- Loading Helpers ---"

    utils_root = "\#{$root}/helpers"

    require "\#{utils_root}/global_utils"
    GlobalUtils.declare_globals

    require "\#{utils_root}/content_helpers"

    # Sinatra Configuration

    configure do
        use Rack::Deflater
        use Rack::Protection, except: [ :remote_token, :session_hijacking ]
        
        set :server, :puma
        set :bind, "0.0.0.0"
    end

    puts "--- Loading Controllers ---"

    controllers = YAML.load_file("\#{$root}/controllerlist.yml")

    controllers.each do |controller|
        require "\#{$root}/controllers/\#{controller["file"]}"
        
        map(controller["path"]) { run eval(controller["name"]) }
    end
CONFIG

contentlist = <<~CONTENTLIST
    ---
    - content
    - welcome
    ...
CONTENTLIST

controllerlist = <<~CONTROLLERLIST
    ---
    -
      file: custom
      name: CustomController
      path: /
    -
      file: content
      name: ContentController
      path: /content
    -
      file: search
      name: SearchController
      path: /search
    ...
CONTROLLERLIST

customlist = <<~CUSTOMLIST
    ---
    -
      name: welcome
      path: /
      title: Welcome
      content:
        - welcome.md
    ...
CUSTOMLIST

dockerfile = <<~DOCKERFILE
    FROM starefossen/ruby-node:2-10

    RUN gem install lei

    WORKDIR /Users/EMC3/Projects/test

    COPY . .

    RUN bundle install

    EXPOSE 80

    CMD puma -b tcp://0.0.0.0:80
DOCKERFILE

gems = <<~GEMS
    source "https://rubygems.org"

    gem "dotenv",       "~>2.2.1"
    gem "puma",         "~>3.11.3"
    gem "rack",         "~>2.0.6"
    gem "rake",         "~>12.3.1"
    gem "redcarpet",    "~>3.4.0"
    gem "rspec",        "~>3.7.0"
    gem "sinatra",      "~>2.0.3"
    gem "slim",         "~>3.0.9"
GEMS

gulp = <<~GULP
    const exec = require("child_process").exec;
    const gulp = require("gulp");
    const pump = require("pump");

    const cleanCSS = require("gulp-clean-css");
    const less = require("gulp-less");

    const lessFiles = `${__dirname}/src/styles/*.less`;
    const excludedLess = `!${__dirname}/src/styles/_*.less`;
    const cssDest = `${__dirname}/static/styles`;

    async function shrink() {
        console.log("** Compiling and minifying .less **");

        await pump(
            [
                gulp.src([ lessFiles, excludedLess ]),
                less(),
                cleanCSS(),
                gulp.dest(cssDest)
            ],
            function(err) {
                if (err) {
                    console.log("--- err:", err);
                }
            }
        );
    }

    gulp.task("shrink", shrink);

    gulp.task("default", gulp.series("shrink", function() {
        console.log("--- Starting .less watcher ---");
        
        gulp.watch(lessFiles).on("change", shrink);
    }));
GULP

ignore = <<~IGNORE
    # Environment Variables
    .env
    nohup.out

    # Certificates
    *.pem
    *.cert

    # Mac File System Artifacts
    .DS_Store

    # Node.js Dependencies
    node_modules

    # ** Content **
    # *.md
IGNORE

illegalchars = <<~ILLEGALCHARS
    ---
    - "."
    - "/"
    ...
ILLEGALCHARS

launch = <<~LAUNCH
    \#!/bin/bash

    \# Provide port number as argument.
    puma -b tcp://0.0.0.0:$1
LAUNCH

package = <<~PACKAGE
    {
        "name": "project-name",
        "version": "1.0.0",
        "repository": "repository-url",
        "author": "your-name",
        "license": "MIT",
        "dependencies": {
            "gulp": "^4.0.0",
            "gulp-clean-css": "3.10.0",
            "gulp-less": "^4.0.0",
            "gulp-uglify": "^3.0.0",
            "pump": "3.0.0"
        }
    }
PACKAGE

loc = "$(pwd)"

dirs = [
    "content",
    "controllers",
    "helpers",
    "index",
    "spec",
    "src",
    "static",
    "views",
    "welcome"
]

makeDirs(dirs, loc)

files = {
    ".gitignore": ignore,
    "banlist.yml": banlist,
    "config.ru": config,
    "contentlist.yml": contentlist,
    "controllerlist.yml": controllerlist,
    "customlist.yml": customlist,
    "Dockerfile": dockerfile,
    "Gemfile": gems,
    "gulpfile.js": gulp,
    "illegalchars.yml": illegalchars,
    "launch.sh": launch,
    "package.json": package
}

makeFiles(files, loc)
