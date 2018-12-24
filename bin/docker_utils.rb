def dockerExists
    versionStdout = `docker -v`

    return versionStdout != nil && versionStdout != ""
end

def dockerNameArgIsValid(nameArg)
    return nameArg != nil && nameArg != "" && nameArg.match(/^\w+$/)
end

def dockerVersionArgIsValid(versionArg)
    return versionArg != nil &&
        versionArg != "" &&
        versionArg.match(/^[0-9]\.[0-9]\.[0-9]$/)
end
