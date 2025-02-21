-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Auto correct
keymap.set("n", "<leader>z", "1z=", { noremap = true, silent = true })

-- Save file and quit
keymap.set("n", "<Leader>a", ":update<Return>", opts)
-- keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
-- keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
-- keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Stay in indent mode after indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Keep last yanked and don't replace it when pasting
keymap.set("v", "p", '"_dP', opts)

-- Stay at center when scrolling
-- keymap.set("n", "<C-d>", "<C-d>zz", opts)
-- keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Stay at center when going to next word in search
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Tabs
keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- Rempap
keymap.set("i", "jj", "<Esc>", opts)

-- Obsidian
keymap.set(
  "n",
  "<leader>oc",
  "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
  { desc = "Obsidian Check Checkbox" }
)

-- funciton to set check boxes
local function make_checkbox()
  -- Get visual selection range
  local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  -- Iterate over each line in selection
  for i = start_line, end_line do
    local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]

    -- Check if line already has a checkbox
    if line and not line:match("^%- %[.%] ") then
      -- Insert "- [ ] " at the beginning of the line
      vim.api.nvim_buf_set_text(0, i - 1, 0, i - 1, 0, { "- [ ] " .. line })
    end
  end
end

-- Keymap for visual mode transformation
keymap.set("v", "<leader>oc", make_checkbox, opts)

keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

-- keymap.set("n", "<leader>nc", "<cmd>lua require('notify').dismiss()<CR>", opts)

keymap.set(
  "v",
  "<leader>cn",
  ":!python3 /home/alireza/.config/nvim/lua/script/cost.py<CR>",
  { desc = "update cost table" }
)

-- lua snippets
-- Only set up the keymaps if luasnip is available
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  local luasnip = require("luasnip")
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  local luasnip = require("luasnip")
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })

-- adding command to run a local run.sh script
-- keymap.set("n", "<leader><CR>", ":!./run.sh<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader><CR>", function()
  -- Get the current working directory from Neovim
  local cwd = vim.fn.getcwd()

  -- Run the tmux command to split the pane and execute the script in the correct directory
  local command = string.format("tmux split-pane -v -p 20 -c '%s' \"zsh -c './run.sh; exec zsh'\"", cwd)
  vim.fn.system(command)
end, { noremap = true, silent = true })

keymap.set("v", "<leader>ma", ":<C-U>'<,'>!bc<CR>", { desc = "Evaluate arithmetic expression with bc" })
