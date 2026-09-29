return {
  -- Mason per gestire l'installazione dei server
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  -- Ponte tra Mason e lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ansiblels" },
      })
    end
  },
  -- Supporto sintassi Lua/Neovim
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Carica i tipi di Neovim per l'autocompletamento
        { path = "luvit-meta/library", word = { "vim%.uv" } },
      },
    },
  },
  -- Alcuni aggiornamenti grafici comodi per lo stato dell'LSP
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  -- Il cuore dell'LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Configurazione ansiblels
      vim.lsp.config.ansiblels.setup = {
        vim.filetype.add({
          extension = {
            yml = function(path, bufnr)
              if vim.fn.search("hosts:\\|tasks:\\|roles:", "nw") ~= 0 then
                return "yaml.ansible"
              end
              return "yaml"
            end,
            yaml = function(path, bufnr)
              if vim.fn.search("hosts:\\|tasks:\\|roles:", "nw") ~= 0 then
                return "yaml.ansible"
              end
              return "yaml"
            end
          },
          pattern = {
            [".*/tasks/.*%.yml"] = "yaml.ansible",
            [".*/tasks/.*%.yaml"] = "yaml.ansible",
            [".*/roles/.*%.yml"] = "yaml.ansible",
            [".*/roles/.*%.yaml"] = "yaml.ansible",
            ["playbook%.yml"] = "yaml.ansible",
            ["playbook%.yaml"] = "yaml.ansible",
          },
        })
      }
      vim.lsp.config.ansiblels.root_markers = { { ".ansible-lint", "ansible-lint.yml" }, ".git" }
      vim.lsp.config.ansiblels.settings = {
        ansible = {
          ansible = {
            path = "/usr/bin/ansible",
          },
          executionEnvironment = {
            enabled = false,
          },
          validation = {
            enabled = true,
            lint = {
              enabled = true,
              path = "/usr/bin/ansible-lint -c /root/.config/ansible-lint.yml",
            }
          }
        }
      }
    end
  },
}
