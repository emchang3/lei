require_relative "../functions"

common = <<~COMMON
    @anim-bg-color: {
        transition: background-color 0.35s, color 0.35s;
    };

    @center-vert: {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    };

    @fs2: {
        font-size: 2em;
    };

    @fs5: {
        font-size: 5em;
    };

    @fs10: {
        font-size: 10em;
    };

    @fw300: {
        font-weight: 300;
    };

    @full-bar-dark: {
        background-color: rgba(0, 0, 0, 0.9);
        box-sizing: border-box;
        color: white;
        width: 100vw;
    };

    @full-bar-light: {
        background-color: rgba(0, 0, 0, 0.1);
        box-sizing: border-box;
        width: 100vw;
    };

    @full-page: {
        font-size: 14px;
        width: 100vw;
        min-height: 100vh;
    };

    @link-content: {
        color: black;
        font-weight: bold;
    };

    @link-ad: {
        color: white;
        text-decoration: none;
    };

    @link-al: {
        color: black;
        text-decoration: none;
    };

    @spread-vert: {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
    };

    @std-content: {
        max-width: 50em;
        width: 80vw;
    };

    @std-margin: {
        margin: 0em;
    };

    @std-padding: {
        padding: 1em;
    };

    .base-page {
        -webkit-tap-highlight-color: transparent;
        font-family: 'Lato', sans-serif;
        background-color: rgb(240, 240, 240);
        @std-margin();

        &::-webkit-scrollbar {
            display: none;
        }

        code {
            background-color: rgba(0, 0, 0, 0.1);
        }

        pre {
            code {
                display: block;
                @std-padding();
            }
        }

        .space-to-left {
            padding-left: 1em;
        }

        .space-to-right {
            padding-right: 1em;
        }
    };

    .main-icon {
        @fs10();
        padding: 0em;
    }

    .std-mp {
        @std-margin();
        @std-padding();
    };

    .page-nav-button {
        padding: 0em;

        a {
            .std-mp;
            @anim-bg-color();
            @full-bar-light();
            @link-al();
            bottom: 0vh;
            display: block;
            text-align: center;
        }

        a:hover {
            @anim-bg-color();
            @full-bar-dark();
            @link-ad();
        }
    }

    .index-section {
        @full-page();
        @spread-vert();

        p:nth-child(2) {
            .main-icon;
        }

        p:last-child {
            .page-nav-button;
        }
    }

    .return-previous {
        p:first-child {
            .page-nav-button;
        }
    }

COMMON

content = <<~CONTENT
    @import "_common";

    html, body {
        .base-page;
    }

    h1 {
        @fw300();
    }

    a {
        outline: transparent;
        text-decoration: none;
        color: black;
    }

    .content {
        padding-bottom: 8px;
        padding-left: 24px;
        padding-right: 24px;
        padding-top: 24px;
        @std-content();
    }

    aside.content {
        display: flex;
    }
CONTENT

notfound = <<~NOTFOUND
    @import "_common";

    html, body {
        .base-page;
    }

    h1 {
        @fw300();
    }

    #not-found {
        @center-vert();
        @full-page();
    }

    .fof {
        @fs10();
    }
NOTFOUND

search = <<~SEARCH
    @import "_common";

    html, body {
        .base-page;
    }

    h1 {
        @fw300();
    }

    #search {
        @center-vert();
        @full-page();

        input, select {
            border: 1px solid rgb(100, 100, 100);
            border-radius: 0.2em;
            display: block;
            font-size: 1.6em;
            margin-bottom: 1em;
            padding: 0.4em;
        }

        input[type="submit"], select {
            width: 100%;
        }

        input:focus, select:focus {
            outline: none;
            box-shadow: 0 0 0 0.05em rgba(0, 123, 255, .5);
        }

        select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }
    }
SEARCH

searchresults = <<~SEARCHRESULTS
    @import "_common";

    html, body {
        .base-page;
    }

    h1 {
        @fw300();
    }

    #results {
        @center-vert();
        @full-page();
    }

    .content {
        padding-bottom: 8px;
        padding-left: 24px;
        padding-right: 24px;
        padding-top: 24px;
        @std-content();
    }
SEARCHRESULTS

welcome = <<~WELCOME
    @import "_common";

    html, body {
        .base-page;
    }

    .main {
        @center-vert();
        @full-page();

        h1 {
            @fs5();
            @fw300();
            text-align: center;
        }

        h2 {
            @fs2();
            @fw300();
        }

        p {
            text-align: center;
        }
    }
WELCOME

dirs = [ "styles" ]

dirLoc = "$(pwd)/src"

makeDirs(dirs, dirLoc)

files = {
    "_common.less": common,
    "content.less": content,
    "notfound.less": notfound,
    "search.less": search,
    "search_results.less": searchresults,
    "welcome.less": welcome
}

filesLoc = "#{dirLoc}/styles"

makeFiles(files, filesLoc)
