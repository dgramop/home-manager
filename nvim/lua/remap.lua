local opts =  { noremap = true, silent = true }
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = '\\'

vim.opt.listchars = { space = '_', eol = '¶', extends = '»', precedes = '«', trail = '•', space = '.' }

--Text rename
vim.keymap.set("n", "<C-t>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>l", "<C-o>")
vim.keymap.set("n", "<leader>n", ":bnext<CR>")
vim.keymap.set("n", "<leader>b", ":bprev<CR>")

-- Remap tab to end of line
vim.keymap.set("n", "<Tab>", "$")
vim.keymap.set("v", "<Tab>", "$")

vim.keymap.set("n", ",s", "<Plug>(GitGutterNextHunk)", opts)
vim.keymap.set("n", ",l", "<Plug>(GitGuttePrevHunk)", opts)

-- Toggle spell check on and off
function toggle_whitespace_list()
  if vim.opt.list then
    vim.opt.list = false
    vim.notify('off')
  else 
    vim.opt.list = true 
    vim.notify('on')
  end
end

vim.keymap.set("", "<leader>,", "<cmd>lua toggle_whitespace_list()<CR>", opts)

-- telescope
local telescope = require('telescope')
vim.keymap.set("n", "<leader>o", "<cmd>lua require('telescope.builtin').find_files()<CR>", {})
vim.keymap.set("n", "<leader><leader>", "<cmd>lua require('telescope.builtin').buffers()<CR>", {})
vim.keymap.set("n", "<leader>s", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {})
