---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<leader>s"] = {
      [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      "Replace word under cursor",
      opts = { noremap = true, silent = true },
    },
    ["<leader>js"] = { "<cmd>w !node<CR>", "Run Node.js" },
    ["<leader>u"] = { "<cmd>UndotreeToggle<CR>", "Toggle Undotree" },
    -- ["<leader>fx"] = { ":silent Bracey<CR>", "Start Live Server" },
  },
  v = {
    [">"] = { ">gv", "indent" },
    -- ["J"] = { ":m '>+1<CR>gv=gv", "Move line down" },
    -- ["K"] = { ":m '<-2<CR>gv=gv", "Move line up" },
  },
  i = {},
}

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-d>", "<C-d>zz", {silent = true})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {silent = true})
vim.keymap.set("n", "n", "nzzzv", {silent = true})
vim.keymap.set("n", "N", "Nzzzv", {silent = true})
vim.keymap.set("n", "<leader><leader>", ":so", { desc = "Source" })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>fx", ":Bracey", {silent = true, desc = "Start Live Server"})

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected lines up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected lines down" })
-- more keybinds!

return M
