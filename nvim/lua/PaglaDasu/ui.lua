return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[

        ██████╗  █████╗  ██████╗ ██╗      █████╗ ██████╗  █████╗ ███████╗██╗   ██╗
        ██╔══██╗██╔══██╗██╔════╝ ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║   ██║
        ██████╔╝███████║██║  ███╗██║     ███████║██║  ██║███████║███████╗██║   ██║
        ██╔═══╝ ██╔══██║██║   ██║██║     ██╔══██║██║  ██║██╔══██║╚════██║██║   ██║
        ██║     ██║  ██║╚██████╔╝███████╗██║  ██║██████╔╝██║  ██║███████║╚██████╔╝
        ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ 

      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      opts.presets.lsp_doc_border = true
    end,
  },

  --[[ {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  }, ]]

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      local filtered_message = { "No information available" }

      -- Override notify function to filter out messages
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(message, level, opts)
        local merged_opts = vim.tbl_extend("force", {
          on_open = function(win)
            local buf = vim.api.nvim_win_get_buf(win)
            vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
          end,
        }, opts or {})

        for _, msg in ipairs(filtered_message) do
          if message == msg then
            return
          end
        end
        return notify(message, level, merged_opts)
      end

      -- Update colors to use catpuccino colors
      vim.cmd([[
        highlight NotifyERRORBorder guifg=#ed8796
        highlight NotifyERRORIcon guifg=#ed8796
        highlight NotifyERRORTitle  guifg=#ed8796
        highlight NotifyINFOBorder guifg=#8aadf4
        highlight NotifyINFOIcon guifg=#8aadf4
        highlight NotifyINFOTitle guifg=#8aadf4
        highlight NotifyWARNBorder guifg=#f5a97f
        highlight NotifyWARNIcon guifg=#f5a97f
        highlight NotifyWARNTitle guifg=#f5a97f
      ]])
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "slant",
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = {},
    event = "BufReadPre",
    priority = 1200,
    -- icon + filename + navic
    --[[ config = function()
      local helpers = require("incline.helpers")
      local navic = require("nvim-navic")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            -- guibg = "#363944",
          }
          if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              table.insert(buffer, {
                { " > ", group = "NavicSeparator" },
                { item.icon, group = "NavicIcons" .. item.type },
                { item.name, group = "NavicText" },
              })
            end
          end
          table.insert(buffer, " ")
          return buffer
        end,
      })
    end, ]]

    -- Icon + Filename
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#44406e",
          }
        end,
      })
    end,
  },
  -- LazyGit integration with Telescope
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {

        "<leader>d",
        "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
      },
    },
  },
}
