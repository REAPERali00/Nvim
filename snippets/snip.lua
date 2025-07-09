local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("sh", {
  s("bash", {
    t("#!/bin/bash"),
  }),
})
ls.add_snippets("python", {
  s("printf", {
    t("print(f'"),
    i(1, "text"),
    t("')"),
  }),
  s("comment", {
    t('"""'),
    i(1, "block comment"),
    t('"""'),
  }),
})
