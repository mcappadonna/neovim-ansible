FROM alpine:latest

RUN <<EOF
apk add git gcc curl fzf npm libc-dev ripgrep
apk add ansible ansible-lint ansible-core-doc
apk add neovim nvim-treesitter
apk cache clean
mkdir -p /root/.config/nvim/lua/ansible
mkdir /code
EOF

COPY --chown=root:root nvim_config/init.lua /root/.config/nvim
COPY --chown=root:root nvim_config/lua/ansible /root/.config/nvim/lua/ansible
COPY --chown=root:root ansible-lint.yml /root/.config

WORKDIR /code

ENTRYPOINT ["/usr/bin/nvim"]
