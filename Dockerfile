FROM alpine:latest

RUN <<EOF
apk add git gcc curl fzf npm libc-dev ripgrep
apk add ansible ansible-lint ansible-core-doc
apk add neovim neovim-doc nvim-treesitter
apk cache clean
mkdir -p /root/.config/nvim
mkdir /code
EOF

COPY --chown=root:root ansible-lint.yml /root/.config

WORKDIR /code

ENTRYPOINT ["/usr/bin/nvim"]
