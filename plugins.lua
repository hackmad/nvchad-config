local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },

  -- Configure telescope dependencies.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("flutter")
    end,
  },

  -- Install plugins
  { "cdelledonne/vim-cmake" },

  { "dart-lang/dart-vim-plugin" },
  { "thosakwe/vim-flutter" },
  { "natebosch/vim-lsc" },
  { "natebosch/vim-lsc-dart" },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false, -- TODO automatically detect Flutter projects and load it.
    dependencies = {
      "nvim-lua/plenary.nvim",
      "dart-lang/dart-vim-plugin",
      "thosakwe/vim-flutter",
      "natebosch/vim-lsc",
      "natebosch/vim-lsc-dart",
    },
    config = function()
      require("flutter-tools").setup {}
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    -- build = "cd app && yarn install",
    build = ":call mkdp#util#install()",
  },

  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = { "sbt", "scala" }, -- TODO automatically detect SBT projects and load it.
    config = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }

      metals_config.init_options.statusBarProvider = "on"

      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Debug settings if you're using nvim-dap
      local dap = require("dap")

      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }

      metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()
      end

      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        -- NOTE: You may or may not want java included here. You will need it if you
        -- want basic Java support but it may also conflict if you are using
        -- something like nvim-jdtls which also works on a java filetype autocmd.
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      max_lines = 0,
      trim_scope = "outer",
      min_window_height = 0,
      patterns = {
        default = {
          "class", "function", "method", "for", "while", "if", "switch", "case",
        },
        rust = {
          "impl_item", "struct", "enum", "function", "method", "loop", "for",
          "while", "if", "match"
        },
        markdown = { "section" },
        json = { "pair" },
        yaml = { "block_mapping_pair" },
      },
      zindex = 20, -- The Z-index of the context window
      mode = "cursor", -- Line used to calculate context. Choices: "cursor", "topline"
      separator = nil,
    },
  },

  { "hashivim/vim-terraform" },

  -- Disable plugins
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

}

return plugins
