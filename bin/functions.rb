def makeDirs(dirs, loc)
    dirs.each { |dir| `mkdir #{loc}/#{dir}` }
end

def makeFiles(files, loc)
    files.each { |k, v| `touch #{loc}/#{k}; echo '#{v}' > #{loc}/#{k}` }
end
