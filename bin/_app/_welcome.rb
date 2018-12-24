welcome = <<~WELCOME
    \#\# Welcome to

    \# Lei
WELCOME

files = {
    "welcome.md": welcome
}

loc = "$(pwd)/welcome"

makeFiles(files, loc)
