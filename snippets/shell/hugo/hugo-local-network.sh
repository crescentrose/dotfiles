# hugo: serve on local network
hugo serve --bind 0.0.0.0 --baseURL="http://$(ipconfig getifaddr en0):1313/"
