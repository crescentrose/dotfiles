FROM alpine:latest

RUN addgroup -S testuser && adduser -S testuser -G testuser

RUN apk add --no-cache neovim git curl fortune bash build-base go

ADD config/nvim /home/testuser/.config/nvim
RUN chown testuser:testuser -R /home/testuser

WORKDIR /home/testuser
USER testuser


ENTRYPOINT ["/usr/bin/nvim"]
