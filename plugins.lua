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
  { "williamboman/mason.nvim", opts = overrides.mason },
  { "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

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
      zindex = 20, -- The Z-index of the context window
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

  { "tpope/vim-fugitive", event = "VeryLazy", cmd = "Git" },

  { "cdelledonne/vim-cmake" },

  { "dart-lang/dart-vim-plugin" },
  { "thosakwe/vim-flutter" },
  { "natebosch/vim-lsc" },
  { "natebosch/vim-lsc-dart" },
  {
    "akinsho/flutter-tools.nvim",
    event = "VeryLazy", -- TODO automatically detect Flutter projects and load it.
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
      metals_config.handlers["metals/status"] = function(_, status, ctx)
        -- https://github.com/scalameta/nvim-metals/blob/main/lua/metals/status.lua#L36-L50
        local val = {}
        if status.hide then
          val = { kind = "end" }
        elseif status.show then
          val = { kind = "begin", message = status.text }
        elseif status.text then
          val = { kind = "report", message = status.text }
        else
          return
        end
        local info = { client_id = ctx.client_id }
        local msg = { token = "metals", value = val }
        -- call fidget progress handler
        vim.lsp.handlers["$/progress"](nil, msg, info)
      end

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
        pattern = {
          "scala",
          "sbt",
          --"java",
        },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
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
    tag = "legacy",
    event = "VeryLazy",
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

  {
    "rcarriga/nvim-dap-ui",
    event = "BufRead",
    dependencies = "mfussenegger/nvim-dap",
    enabled = vim.fn.has "win32" == 0,
    config = function()
      require "custom.configs.dapui"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "BufRead",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    enabled = vim.fn.has "win32" == 0,
    config = function()
      require "custom.configs.mason_dap"
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("dap-python").setup "~/.virtualenvs/debugpy/bin/python"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local jdtls = require "jdtls"
      local jdtls_path = "/usr/local/Cellar/jdtls/1.23.0/libexec"
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.expand("$HOME" .. "/.workspace/" .. project_name)

      local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

        "-configuration",
        jdtls_path .. "/config_mac",

        "-data",
        workspace_dir,
      }

      local settings = {
        java = {
          eclipse = { downloadSources = true },
          configuration = {
            updateBuildConfiguration = "interactive",
            runtimes = {},
          },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          format = { enabled = true },
        },
        signatureHelp = {
          enabled = true,
        },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
        },
        contentProvider = {
          preferred = "fernflower",
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          useBlocks = true,
        },
      }

      local bundles = {
        vim.fn.glob(
          vim.fn.expand(
            "$HOME"
              .. "/Software/java-debug//com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
            1
          )
        ),
      }
      vim.list_extend(
        bundles,
        vim.split(vim.fn.glob(vim.fn.expand("$HOME" .. "/Software/vscode-java-test/server/*.jar"), 1), "\n")
      )

      -- Debug settings if you're using nvim-dap
      local dap = require "dap"
      dap.configurations.java = {}

      local on_attach = function(client, bufnr)
        require("jdtls").setup_dap { hotcodereplace = "auto" }
        require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()
      end

      jdtls.start_or_attach {
        cmd = cmd,
        settings = settings,
        init_options = { bundles = bundles },
        on_attach = on_attach,
        capabilities = require("plugins.configs.lspconfig").capabilities,
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
