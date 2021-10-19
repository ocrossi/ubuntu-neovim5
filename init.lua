local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- mapping and settings helpers
local utils = {}

function utils.map(type, key, value, opts) -- the other functions are just for more vim-feel usage
  local options = opts or {}
  vim.api.nvim_set_keymap(type, key, value, options)
end
function utils.noremap(type, key, value, opts)
  local options = {noremap = true}
--  if opts then
--    options = vim.tbl_extend('force', options, opts)
--  end
  vim.api.nvim_set_keymap(type,key,value, options)
end
function utils.nnoremap(key, value, opts)
  utils.noremap('n', key, value, opts)
end
function utils.inoremap(key, value, opts)
  utils.noremap('i', key, value, opts)
end
function utils.vnoremap(key, value, opts)
  utils.noremap('v', key, value, opts)
end
function utils.xnoremap(key, value, opts)
  utils.noremap('x', key, value, opts)
end
function utils.tnoremap(key, value, opts)
  utils.noremap('t', key, value, opts)
end
function utils.cnoremap(key, value, opts)
  utils.noremap('c', key, value, opts)
end
function utils.nmap(key, value, opts)
  utils.map('n', key, value, opts)
end
function utils.imap(key, value, opts)
  utils.map('i', key, value, opts)
end
function utils.vmap(key, value, opts)
  utils.map('v', key, value, opts)
end
function utils.tmap(key, value, opts)
  utils.map('t', key, value, opts)
end

P = function(stuff) return print(vim.inspect(stuff)) end

-- SET OPTS --> EG --> opt('b', 'expandtab', true)
local scopes = {o = vim.o, b = vim.bo, w = vim.wo, g = vim.g}
function utils.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end


-- ===== real config starts here =====
local g = vim.g
local o = vim.o

vim.o.completeopt = "menuone,noselect"

g.mapleader = " "
-- vim.o.noswapfile = true

-- tab config
utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', 2)
utils.opt('b', 'tabstop', 2)
utils.opt('b', 'softtabstop', 2)

vim.cmd('syntax on')

utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)

vim.bo.smartindent = true
--vim.wo.colorcolumn = 80

utils.opt('o', 'ignorecase', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'incsearch', true)
utils.opt('o', 'hlsearch', false)

-- split in reasonable positions
utils.opt('o', 'splitright', true)
utils.opt('o', 'splitbelow', true)


utils.nnoremap('<c-j>', '<c-w>j') 
utils.nnoremap('<c-k>', '<c-w>k') 
utils.nnoremap('<c-h>', '<c-w>h') 
utils.nnoremap('<c-l>', '<c-w>l')
utils.nnoremap('<Leader><left>', ':tabprev<cr>')
utils.nnoremap('<Leader><right>', ':tabnext<cr>')
utils.nnoremap('<F5>', ':tabnew<cr>')
utils.nnoremap('<F3>', ':sp<cr>')
utils.nnoremap('<F4>', ':vsp<cr>')
utils.nnoremap('<F5>', ':tabnew<cr>')
utils.nnoremap('<F10>', ':w<cr>')
utils.nnoremap('<F12>', ':qall<cr>')
utils.nnoremap('<Leader>h', ':nohlsearch<cr>')
utils.nnoremap('<c-a>', '0')
utils.nnoremap('<c-e>', '$')
utils.inoremap('<F10>', '<esc>:w<cr>')
utils.inoremap('<c-a>', '<esc>0i')
utils.inoremap('<c-e>', '<esc>$i')
utils.vnoremap('<F10>', '<esc>:w<cr>')


vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  use {'wbthomason/packer.nvim', opt = true}
  use {'tpope/vim-fugitive'}
  use {'morhetz/gruvbox'}
  use {'neovim/nvim-lspconfig'}
  use {'nvim-treesitter/nvim-treesitter'}
  use {'hrsh7th/nvim-compe'}
  use {'nvim-telescope/telescope.nvim'}
  use {'SirVer/ultisnips'}
  use {'mhartington/formatter.nvim'}
  use {'honza/vim-snippets'}
end)
-- update plugins
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[PackerInstall]])
vim.g.gruvbox_contrast_dark="hard"
vim.cmd("colorscheme gruvbox")

-- ===== find project root for quick cd =====
local api = vim.api
function find_project_root()
  local id = [[.git]]
  local file = api.nvim_buf_get_name(0)
  local root = vim.fn.finddir(id, file .. ';')
  if root ~= "" then
    root = root:gsub(id, '')
    print(root)
    vim.api.nvim_set_current_dir(root)
  else
    print("No repo found.")
  end
end

-- ===== statusline =====
local stl = {' %M', ' %y', ' %r', ' %{pathshorten(expand("%:p"))}', ' %{FugitiveStatusline()}',
  '%=', ' %c:%l/%L'
}
vim.o.statusline = table.concat(stl)

-- ===== telescope setup =====
require('telescope').setup{
  --defaults excluded to reduce lines :P
}
utils.nnoremap('<leader>b', '<cmd>Telescope buffers<cr>')
utils.nnoremap('<leader>o', '<cmd>Telescope find_files<cr>')
utils.nnoremap('<leader>h', '<cmd>Telescope oldfiles<cr>')
utils.nnoremap('<leader>c', '<cmd>Telescope commands<cr>')
utils.nnoremap('<leader>ch', '<cmd>Telescope command_history<cr>')
utils.nnoremap('<leader>f', '<cmd>Telescope live_grep<cr>')
utils.nnoremap('<leader>z', '<cmd>Telescope spell_suggest<cr>')
utils.noremap('','<F1>', '<cmd>Telescope help_tags<cr>')

-- ===== simple session management =====
local session_dir = vim.fn.stdpath('data') .. '/sessions/'
utils.nnoremap('<leader>ss', ':mks! ' .. session_dir)
utils.nnoremap('<leader>sr', ':%bd | so ' .. session_dir)

-- ===== completion settings =====
vim.o.completeopt="menuone,noinsert,noselect"
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_enable_snippet = 'UltiSnips'
vim.g.completion_matching_ignore_case = 1
vim.g.completion_trigger_keyword_length = 3

-- ===== snippets =====
vim.g.UltiSnipsExpandTrigger='<leader>s'
vim.g.UltiSnipsListSnippets='<c-l>'
vim.g.UltiSnipsJumpForwardTrigger='<c-b>'
vim.g.UltiSnipsJumpBackwardTrigger='<c-z>'
vim.g.UltiSnipsEditSplit='vertical'

-- ===== lsp setup =====
local custom_attach = function(client)
	print("LSP started.");
	require'completion'.on_attach(client)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false, update_in_insert = false }
  )
  -- automatic diagnostics popup
  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
  -- speedup diagnostics popup
  vim.o.updatetime=1000
  utils.nnoremap('gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
  utils.nnoremap('<c-]>','<cmd>lua vim.lsp.buf.definition()<CR>')
  utils.nnoremap('K','<cmd>lua vim.lsp.buf.hover()<CR>')
  utils.nnoremap('gr','<cmd>lua vim.lsp.buf.references()<CR>')
  utils.nnoremap('gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
  utils.nnoremap('gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  utils.nnoremap('<F5>','<cmd>lua vim.lsp.buf.code_action()<CR>')
  utils.nnoremap('<leader>r','<cmd>lua vim.lsp.buf.rename()<CR>')
  utils.nnoremap('<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  utils.nnoremap('<leader>d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  utils.nnoremap('<leader>D', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
end
-- setup all lsp servers here
local nvim_lsp = require'lspconfig'
nvim_lsp.clangd.setup{on_attach=custom_attach}
nvim_lsp.bashls.setup{on_attach=custom_attach}
nvim_lsp.texlab.setup{on_attach=custom_attach}
nvim_lsp.pyls.setup{on_attach=custom_attach}
nvim_lsp.tsserver.setup{on_attach=custom_attach}
nvim_lsp.sumneko_lua.setup{
  cmd = {'lua-language-server'},
  on_attach=custom_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = { vim.split(package.path, ';') },
      },
      completion = { keywordSnippet = "Disable", },
      diagnostics = {enable = true, globals = {"vim","describe","it","before_each","after_each"}
      },
      workspace = {
        library = { [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true},
        maxPreload = 1000,
        preloadFileSize = 1000,
      }
    }
  }
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "lua", "bash", "python", "typescript", "javascript"},
  highlight = { enable = true },
}


-- compe setup 
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}
