local overrides = require "custom.configs.overrides"

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

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "custom.configs.indent-blankline"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        cache_picker = {
          num_pickers = 10,
        },
      },
    },
  },

  -- Override plugin configs
  { "williamboman/mason.nvim",         opts = overrides.mason },
  { "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
  { "nvim-tree/nvim-tree.lua",         opts = overrides.nvimtree },

  -- Install plugins
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      enable = true,
      max_lines = 0,
      trim_scope = "outer",
      min_window_height = 0,
      patterns = {
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
        },
        rust = {
          "impl_item",
          "struct",
          "enum",
          "function",
          "method",
          "loop",
          "for",
          "while",
          "if",
          "match",
        },
        markdown = { "section" },
        json = { "pair" },
        yaml = { "block_mapping_pair" },
      },
      zindex = 20,     -- The Z-index of the context window
      mode = "cursor", -- Line used to calculate context. Choices: "cursor", "topline"
      separator = nil,
    },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
    cmd = "Git",
  },

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
      require("telescope").load_extension "flutter"
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
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
      local dap = require "dap"

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
    lazy = false,
    config = function()
      require("spectre").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("trouble").setup {
        auto_open = false,
        auto_close = false,
        mod = "document_diagnosis",
      }
    end,
  },

  {
    "j-hui/fidget.nvim",
    lazy = false,
    config = function()
      require("fidget").setup {
        text = {
          spinner = "moon",
          done = "✔",
          commenced = "Started",
          completed = "Completed",
        },
        window = {
          blend = 50,
        },
      }
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- Disable plugins
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
}

return plugins
