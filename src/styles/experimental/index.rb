opt05 = "transition: opacity 0.5s;"

index = <<~INDEX
    html, body {
        width: 100%;
        height: 100%;
        margin: 0px;
        font-family: 'Ubuntu', sans-serif;
    }

    .landing-content {
        padding: 24px;
        
        &.hidden {
            opacity: 0;
            #{opt05}
        }

        &.shown {
            opacity: 1;
            #{opt05}
        }
    }
INDEX

# Run from project root, typically by gulp.
`echo '#{index}' > src/styles/index.less`