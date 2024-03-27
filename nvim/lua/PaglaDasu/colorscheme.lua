--[[return {
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_transparent_background = "1"
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "andromeda"
      vim.cmd.colorscheme("sonokai")
    end,
  },
}--]]

return {
  {
    "shaunsingh/moonlight.nvim",
    priority = 1000,
    config = function()
      vim.g.moonlight_italic_comments = true
      vim.g.moonlight_italic_keywords = true
      vim.g.moonlight_italic_functions = true
      vim.g.moonlight_italic_variables = false
      vim.g.moonlight_contrast = false
      vim.g.moonlight_borders = false
      vim.g.moonlight_disable_background = false
    end,
  },
}

--[[ return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.g.compile = true
      vim.g.undercurl = true
      vim.g.theme = "dragon"
      _G.s = {
        override_colors = function()
          vim.g.NormalFloat = { bg = "none" }
          vim.g.FloatBorder = { bg = "none" }
          vim.g.FloatTitle = { bg = "none" }
        end,
      }
    end,
  },
} ]]
