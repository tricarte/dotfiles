return {
  "L3MON4D3/LuaSnip",
  config = function(_, opts)
    require("luasnip").filetype_extend("dart", { "flutter" })
  end,
}
