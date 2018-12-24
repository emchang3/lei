require_relative "../functions"

common = <<~COMMON
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

    @full-page: {
        width: 100vw;
        min-height: 100vh;
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
        font-family: "Lato", sans-serif;
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
    "welcome.less": welcome
}

filesLoc = "#{dirLoc}/styles"

makeFiles(files, filesLoc)
