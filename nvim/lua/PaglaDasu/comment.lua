return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      toggler = {
        line = "go",
        block = "gob",
      },
      extra = {
        ---Add comment on the line above
        above = "gcO",
        ---Add comment on the line below
        below = "gco",
        ---Add comment at the end of line
        eol = "gca",
      },
      sticky = true,
    },
    config = true,
  },
}
