local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("markdown", {
  s("- explanation", {
    t("- `"),
    i(1, "code"),
    t("` -> "),
    i(2, "explanation"),
  }),
})

ls.add_snippets("all", {
  s("name", {
    t("Alireza Jadidi"),
  }),
})
