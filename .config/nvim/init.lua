-- Last Modified Date: <2026-08-16 Sun>
-- Desc              : NEOVIM 0.12.4(support Python, Lua)
--                          __
--  __  ____   __   __  __ /\_\    ___ ___     ____   ____
-- |  \/  \ \ / /  /\ \/\ \\/\ \ /'' __` _`\  |  _ \ / ___|
-- | |\/| |\ V /   \ \ \_/ |\ \ \/\ \/\ \/\ \ | |_) | |
-- | |  | | | |     \ \___/  \ \_\ \_\ \_\ \_\|  _ <| |___
-- |_|  |_| |_|      \/__/    \/_/\/_/\/_/\/_/|_| \_\\____|
-- ========================================================

-- {{{ mapping - original neovim
vim.g.mapleader      = " "
vim.g.maplocalleader = ","

local neomap        = vim.keymap.set  -- vim.api.nvim_set_keymap
local key_opts_ns   = { noremap = true, silent = true }
local key_opts_n    = { noremap = true }
local key_opts_s    = { silent = true }
neomap("", ";", ":", key_opts_n)
neomap({ "n", "x" }, "s", "<nop>", key_opts_ns)
neomap({ "n", "x" }, "r", "<nop>", key_opts_ns)
-- x,c仅复制,不更改寄存器.(d为剪切)
neomap("n", "x", "\"_x", key_opts_ns)
neomap("v", "x", "\"_x", key_opts_ns)
neomap("n", "c", "\"_c", key_opts_ns)
neomap("v", "c", "\"_c", key_opts_ns)
neomap("n", "Y", "y$", key_opts_ns)
neomap("v", "p", "pgvy", key_opts_ns)
neomap("v", "P", "Pgvy", key_opts_ns)
-- 光标移动
neomap("i", "<m-h>", "<Left>", key_opts_ns)
neomap("i", "<m-j>", "<Down>", key_opts_ns)
neomap("i", "<m-k>", "<Up>", key_opts_ns)
neomap("i", "<m-l>", "<Right>", key_opts_ns)
-- INSERT Mode下使用光标移动一个单词
neomap("i", "<C-h>", "<C-Left>", key_opts_ns)
neomap("i", "<C-l>", "<C-Right>", key_opts_ns)
-- Indentation
neomap("n", "<", "<<", key_opts_ns)
neomap("n", ">", ">>", key_opts_ns)
-- marks
neomap("n", "mc", ":delmarks!<cr>", key_opts_ns)  --删除所有小写marks
neomap("n", "mC", ":delmarks A-Z<cr>", key_opts_ns)  --删除所有大写marks
-- 单词的 选/改/删
--[[ neomap("n", "vi", "viw", key_opts_ns)
neomap("n", "ci", "ciw", key_opts_ns)
neomap("n", "di", "diw", key_opts_ns) ]]
-- IDE like delete
neomap("i", "<C-BS>", "<Esc>b\"_dei", key_opts_ns)
-- 代码折叠
neomap("n", "<Tab>", "@=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>", key_opts_ns)
-- zf:创建折叠;zd:删除折叠,仅在manual/marker中有效;zD:删除嵌套折叠,仅在manual/marker中有效;za:打开/关闭当前折叠;zM:关闭所有折叠;zR:打开所有折叠
-------------------- copy path(file) --------------------
-- path without filename
-- neomap("n", "<leader>y", [[:let @+=('cd ' .. expand('%:p:h'))<CR>:echo "File path in clipboard"<CR>]], { desc = 'Copy Path(file)' }) -- 路径没有引号
neomap("n", "<leader>y", [[:let @+=('cd ' .. "'" .. expand('%:p:h') .. "'")<CR>:echo "File path in clipboard"<CR>]], { desc = '[Y]ank Path (file)' }) -- 路径有引号
-- if "expand('%:p')", path with filename
-------------------- spell checking --------------------
-- 设置拼写检查开关
neomap('n', '<Leader>sc', ':set spell!<CR>', { desc = 'Spell Word' })
-- 拼写检查导航
neomap('n', '<leader>sn', ']s', { desc = 'Next Wrong Word' })
neomap('n', '<leader>sp', '[s', { desc = 'previou Wrong Word' })
neomap('n', '<leader>sa', 'zg', key_opts_ns)
-- 显示单词拼写建议
neomap('n', '<leader>s?', 'z=', { desc = 'Word Candidate' })
-- 查找并替换
neomap('n', '<leader>z', [[:%s/\<<C-R>=expand("<cword>")<CR>\>/<C-R>=expand("<cword>")<CR>/g<left><left>]], { desc = 'Replace Word' })
neomap('v', '<leader>z', [[:s///g<left><left><left>]], { desc = 'Replace Word' })
-- 统计中文字数
neomap('n', '<localleader>w', [[:s/\v[\u4E00-\u9FFF\u3000-\u303F\uFF00-\uFFEF]//gn<CR>]])
neomap('v', '<localleader>w', [[:s/\v[\u4E00-\u9FFF\u3000-\u303F\uFF00-\uFFEF]//gn<CR>]])
-- 创建列表
neomap('n', '<leader>b', [[:put =range(,,1)<left><left><left><left>]], { desc = 'Columns Num' })
-------------------- 分屏 --------------------
-- 分屏后窗口最大化和恢复
neomap("n", "<m-,>", "<c-w>_<c-w>|", key_opts_ns)
neomap("n", "<m-.>", "<c-w>=", key_opts_ns)
-- 互换分割窗口
neomap('n', '<S-h>', '<C-w>b<C-w>H', key_opts_ns)
-- neomap('n', 'srh', '<C-w>b<C-w>K', {}) -- 注释掉，因为与 <S-h> 冲突
-- 光标移动
neomap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
neomap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
neomap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
neomap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- 终端分屏窗口移动，split navigations,smart way to move between windows
neomap('t', '<C-h>', '<C-w><C-h>', key_opts_s)
neomap('t', '<C-j>', '<C-w><C-j>', key_opts_s)
neomap('t', '<C-k>', '<C-w><C-k>', key_opts_s)
neomap('t', '<C-l>', '<C-w><C-l>', key_opts_s)
neomap('t', '<Esc>', '<C-\\><C-n>', key_opts_s)
-- 调整分屏尺寸
neomap('n', '<S-up>', ':resize -3<CR>', key_opts_ns)
neomap('n', '<S-down>', ':resize +3<CR>', key_opts_ns)
neomap('n', '<S-left>', ':vertical resize +3<CR>', key_opts_ns)
neomap('n', '<S-right>', ':vertical resize -3<CR>', key_opts_ns)
-------------------- Quickfix list --------------------
function toggle_quickfix()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
            break
        end
    end
    if qf_exists then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end
neomap('n', '<leader>Q', '<cmd>lua toggle_quickfix()<CR>', { desc = '[Q]uickfix list toggle' })
-------------------- 标签页 --------------------
-- 将新的空白缓冲区替换当前页
neomap('n', '<c-w>e', ':enew<cr>', key_opts_ns)
-- 新建标签页
neomap('n', '<leader><Tab>', ':tabnew<CR>', { desc = '[Tab]new' })
-- 支持Alt+n切换标签页
neomap('n', '<M-1>', '1gt', key_opts_ns)
neomap('n', '<M-2>', '2gt', key_opts_ns)
neomap('n', '<M-3>', '3gt', key_opts_ns)
neomap('n', '<M-4>', '4gt', key_opts_ns)
neomap('n', '<M-5>', '5gt', key_opts_ns)
neomap('n', '<M-6>', '6gt', key_opts_ns)
neomap('n', '<M-7>', '7gt', key_opts_ns)
neomap('n', '<M-8>', '8gt', key_opts_ns)
neomap('n', '<M-9>', '9gt', key_opts_ns)
neomap('n', '<M-0>', ':tablast<CR>', key_opts_ns)
-- Alt+左右键来移动标签顺序
neomap('n', '<M-left>', [[<Cmd>if tabpagenr() == 1 | execute "tabm " . tabpagenr("$") | else | execute "tabm " . (tabpagenr()-2) | endif<CR>]], key_opts_ns)
neomap('n', '<M-right>', [[<Cmd>if tabpagenr() == tabpagenr("$") | tabm 0 | else | execute "tabm " . tabpagenr() | endif<CR>]], key_opts_ns)
-- buffer
neomap('n', '<leader>q', ':bd<CR>', { desc = '[Q]uit/Kill Buffer' })  -- bd!: quit even not save
------------- Command Mode related ---------------
neomap('c', '<C-a>', '<Home>', key_opts_n)
neomap('c', '<C-e>', '<End>', key_opts_n)
-- neomap('c', '<C-K>', '<C-U>', key_opts_n)
neomap('c', '<C-h>', '<C-Left>', key_opts_n)
neomap('c', '<C-l>', '<C-Right>', key_opts_n)
-- cmdline move
neomap('c', '<M-h>', '<left>', key_opts_n)
neomap('c', '<M-l>', '<right>', key_opts_n)
neomap('c', '<M-j>', '<down>', key_opts_n)
neomap('c', '<M-k>', '<up>', key_opts_n)
neomap('c', '<C-j>', '<down>', key_opts_n)
neomap('c', '<C-k>', '<up>', key_opts_n)
-- 在命令行粘贴的快捷键
neomap('c', '<C-V>', '<C-R>+', key_opts_n)
-- -------------------- function --------------------
-- open Startify
neomap('n', '<leader>st', ':Startify<CR>', { desc = 'Startify' })
-- diff this
neomap('n', '<leader>dt', ':windo diffthis<CR>', { desc = '[D]iff [T]his' })
-- vimrc
neomap('n', '<leader>rc', ':edit $MYVIMRC<CR>', { desc = 'Edit VIMRC' })
neomap('n', '<leader>rr', ':restart<CR>', { desc = '[R]eload VIMRC' })
-- 取消高亮
neomap('n', '<BS>', ':nohlsearch<CR>', key_opts_ns)
-- 显示列表，使用`.`表示空格
neomap('n', '<F3>', ':set list!<CR>', key_opts_ns)
neomap('i', '<F3>', '<C-o>:set list!<CR>', key_opts_ns)
neomap('c', '<F3>', '<C-c>:set list!<CR>', key_opts_ns)
-- 高亮光标行列
neomap('n', '<F4>', ':set cuc! cul!<CR>', key_opts_ns)
neomap('i', '<F4>', '<C-o>:set cuc! cul!<CR>', key_opts_ns)
-- smart split
function Smart_split()
    if vim.api.nvim_win_get_width(0) > vim.api.nvim_win_get_height(0) * 3 then
        -- vim.cmd("vsplit")  --当前文件分屏
        vim.cmd("vnew")  --空白分屏
    else
        -- vim.cmd("split")  --当前文件分屏
        vim.cmd("new")  --空白分屏
    end
end
neomap('n', '<leader>\\', ':lua Smart_split()<CR>', { desc = 'Smart split' })
-- }}}

-- {{{ font
-- English (all have Nerd): 'Delugia Mono' ≈ Cascadia Code; 'CodeNewRoman NFM'; 'OperatorMono NF'; 'ComicMono NF'
-- 中文: 'Noto Sans Mono CJK SC' (whitout Nerd); LXGW WenKai Mono (whitout Nerd); 'inconsolatago qihei nf' (Nerd)
vim.opt.guifont     = "Delugia Mono:h12"
-- vim.opt.guifontwide = "Noto Sans Mono CJK SC:h12"
vim.opt.guifontwide = "LXGW WenKai Mono:h12"
-- Adjust fontsize
vim.cmd[[
let s:guifontsize=12
let s:guifont="Delugia\\ Mono"
"let s:guifontwide="Noto\\ Sans\\ Mono\\ CJK\\ SC"
let s:guifontwide="LXGW\\ WenKai\\ Mono"

function! AdjustFontSize(amount)
    let s:guifontsize = s:guifontsize + a:amount
    execute "set guifont=" .. s:guifont .. ":h" .. s:guifontsize
    execute "set guifontwide=" .. s:guifontwide .. ":h" .. s:guifontsize
endfunction

function!  AdjustFontSize_0()
    execute "set guifont=" .. s:guifont .. ":h12"
    execute "set guifontwide=" .. s:guifontwide .. ":h12"
endfunction
]]
-- keyboard
neomap("n", "<C-->", ":call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("n", "<C-=>", ":call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("n", "<C-0>", ":call AdjustFontSize_0()<CR>", key_opts_ns)

neomap("i", "<C-->", "<C-o>:call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("i", "<C-=>", "<C-o>:call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("i", "<C-0>", "<C-o>:call AdjustFontSize_0()<CR>", key_opts_ns)
-- mouse
neomap("n", "<C-ScrollWheelUp>", ":call AdjustFontSize(1)<CR>", key_opts_ns)
neomap("n", "<C-ScrollWheelDown>", ":call AdjustFontSize(-1)<CR>", key_opts_ns)
neomap("i", "<C-ScrollWheelUp>", "<ESC>:call AdjustFontSize(1)<CR>a", key_opts_ns)
neomap("i", "<C-ScrollWheelDown>", "<ESC>:call AdjustFontSize(-1)<CR>a", key_opts_ns)
-- }}}

-- {{{ options
vim.g.have_nerd_font = true
vim.opt.autochdir = false  -- 设定文件浏览器目录为当前目录  --wenti
vim.opt.autoindent = true  -- 自动对齐
vim.opt.autoread = true  -- 自动读取
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false
vim.opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
vim.opt.clipboard = "unnamedplus"  -- Sync with system clipboard
vim.opt.cmdheight = 1
vim.opt.confirm = true
vim.opt.cursorline = false
vim.opt.encoding = "utf-8"
vim.opt.errorbells = false
vim.opt.expandtab = true  -- 在输入tab后,vim用个空格来填充这个tab
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,gbk,gb18030,big5,ucs-bom,euc-jp,latin1"
vim.opt.foldenable = true
vim.opt.foldlevel = 33
vim.opt.foldmethod = 'marker'  -- 折叠类型---对文中标志折叠
vim.opt.formatoptions = "1jcroql"
vim.opt.hidden = true  -- 允许在有未保存的修改时切换缓冲区
vim.opt.showmode = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true  -- 忽略大小写
vim.opt.incsearch = true  -- 开启实时搜索功能
vim.opt.laststatus = 2  -- 3:global Statusline, default is 2
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.magic = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false  -- 右下角显示光标位置的状态行
vim.opt.scrolloff = 5  -- 设置目标行与顶部底部的距离(5行)
vim.opt.sessionoptions = "buffers,curdir,help,tabpages,winsize"
vim.opt.shiftround = true
vim.opt.shiftwidth = 4  -- Size of an indent
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"
vim.opt.showmatch = true  -- 显示括号配对情况
vim.opt.sidescroll = 5
vim.opt.sidescrolloff = 15
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true  -- Insert indents automatically
vim.opt.softtabstop = 4  -- 退格键的长度
vim.opt.spelllang = "en_us"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 4  -- 设置tab键的宽度
vim.opt.termguicolors = true
-- vim.opt.ttimeoutlen = 0  --wenti
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.timeout = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.visualbell = true
vim.opt.whichwrap = "h,l,<,>,[,],~"  -- 允许backspace和光标键跨越行边界
vim.opt.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
vim.opt.wildignorecase = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"  -- Command-line completion mode
vim.opt.wrap = true
vim.opt.writebackup = false
vim.opt.inccommand="nosplit"
vim.opt.winborder = 'rounded'
vim.opt.foldcolumn = "2"
vim.opt.splitkeep = "screen"
vim.opt.shortmess:append({ C = true })

-- Windows or WSL2: Requires equalsraf/win32yank.  try: choco install win32yank
vim.g.clipboard = {
    name = 'win32yank',
    copy = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
}
-- ENV-Python
vim.g.python3_host_prog = vim.fn.has("unix") == 1
    and "/usr/bin/python3"
    or "C:/Python/Python311/python.exe"
vim.cmd([[ let $PYTHONUNBUFFERED=1 ]]) -- 禁用python stdout缓冲 ]

-- Return to last edit position when opening files (You want this!)
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])

-- neovim 0.12 new feature
require('vim._core.ui2').enable({
    enable = true,
    msg = {
        target = "msg", -- options: cmd(classic), msg(similar to noice)
        pager = { height = 1 },
        msg   = { height = 0.5, timeout = 4500 },
        dialog = { height = 0.5 },
        cmd    = { height = 0.5 },
    },
})
-- }}}

-- {{{ autocmds

-- 文件类型设置
-- 设置高亮: norg --> org, rpy --> python
vim.filetype.add({
    extension = {
        rpy = "python",
        norg = "org",
    },
})

-- nvim_create_augroups(autocmds)
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(
                vim.iter({ "autocmd", def }):flatten():totable(),
                " "
            )
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

nvim_create_augroups({
    file_options = {
        { "BufNewFile,BufRead", "*.py", "set fileformat=unix" },
        { "BufNewFile,BufRead", "*.m", "set fileencoding=cp936" },  -- matlab中文乱码
        { "BufRead", "*.md", "set conceallevel=2" },
    },
    autosave_shada = {
        { "VimLeave", "*", "wshada!" },
    },  -- save marks
    textwidth_by_filetype = {
        { "FileType", "tex", "setlocal textwidth=72" },
        { "FileType", "markdown", "setlocal textwidth=80" },
    },
    highlight_column_limit = {
        -- 下划线显示第80个字符
        {
            "BufRead,BufNewFile",
            "*.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.hs,*.vim,*.md",
            [[2match Underlined /.\%81v/]],
        },
        -- 下划线显示第72个字符(遵循Fortran77固定格式)
        {
            "BufRead,BufNewFile",
            "*.for",
            [[2match Underlined /.\%73v/]],
        },
    },
})

-- 当 Neovim 重新获得焦点、进入 buffer 或停留时，检测文件是否被外部修改
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  command = "checktime",
})
-- 当文件被外部更改后，提示代码已修改
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.fn.confirm(" File changed on disk!", "OK", 1)
  end,
})

-- 复制时高亮显示文本
vim.api.nvim_set_hl(0, "MyYankHighlight", { fg = "#000000", bg = "#8fc1cc", bold = true })  -- #c34043
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank({
            higroup = 'MyYankHighlight',
            timeout = 200,
        })
    end,
})

-- }}}

-- {{{ plugins
-- {{{ Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "mg979/vim-visual-multi",
    keys = {
        { "<C-Up>", desc = "Visual Multi up" },
        { "<C-Down>", desc = "Visual Multi down" },
        { "<C-z>", desc = "Visual Multi select all" },
        { "<C-n>", mode = { "n", "x" }, desc = "visual multi" },
    },
    init = function()
      vim.g.VM_highlight_matches = 'underline'
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select All"]         = "<C-z>",
        ["Add Cursor Up"]      = "<C-Up>",
        ["Add Cursor Down"]    = "<C-Down>",
      }
    end,
  },
-- }}}

-- {{{ nvim-lualine/lualine.nvim
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()

    local function modified()
      if vim.bo.modified then
        return '[+]'  -- +
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return '-'
      end
      return ''
    end

    local function search_result()
      if vim.v.hlsearch == 0 then
        return ''
      end
      local last_search = vim.fn.getreg('/')
      if not last_search or last_search == '' then
        return ''
      end
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
      return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = { 'snacks_dashboard', 'startify' },
                winbar = { 'snacks_dashboard' },
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            }
        },
        sections = {
            lualine_a = {
                {
                    'windows',
                    use_mode_colors = true,
                    show_filename_only = true,
                    show_modified_status = false,
                    mode = 0,
                    max_length = vim.o.columns * 2 / 3,
                    symbols = {
                        modified = ' [+]',  -- 🈚, [+], , ' [𝓐 ]'
                        alternate_file = '#',
                        directory =  '',
                    },
                    filetype_names = {
                        startuptime = '⏳',
                    },
                    padding = { right = 1 },  -- 该组件右侧空白长度
                },
                {   modified, color = { fg = '#ca1243', gui = 'bold' }, padding = { left = 0 }, },  -- bg = '#ca1243'
            },
            lualine_b = {
                {
                    'branch', icon = {'', align='right', color={fg='#ff8800'}},
                },  --  
                {
                    'diff',
                    symbols = {added = '+', modified = '~', removed = '-'},
                },
                {
                    'diagnostics',
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "hint", "info" },
                    symbols = {
                        error = ' ',
                        warn  = ' ',
                        hint  = ' ',
                        info  = ' ',
                    },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                    cond = function()
                        return vim.diagnostic.is_enabled()
                    end,
                },
            },
            lualine_c = {
                {
                    'filename',
                    file_status = false,
                    newfile_status = false,
                    path = 2,
                    shorting_target = 40,
                },
            },
            lualine_x = {
                {
                    '%S',
                },
                {
                    'encoding',
                },
                {
                    search_result,
                },
                {
                    'filetype',
                    colored = true,
                    icon_only = true,
                },
            },  -- 'os.date("%H:%M %a")'
            lualine_y = { '%c' },
            lualine_z = { '%l - %L' },
        },
        extensions = {
            "neo-tree"
        }
    }

    --Match colorscheme
    local max_lualine_theme_frappe_transparent = require('lualine_custom_theme').max_lualine_theme_frappe_transparent
    local max_lualine_theme_latte_transparent  = require('lualine_custom_theme').max_lualine_theme_latte_transparent
    local max_lualine_theme_frappe             = require('lualine_custom_theme').max_lualine_theme_frappe
    local max_lualine_theme_latte              = require('lualine_custom_theme').max_lualine_theme_latte
    local max_lualine_theme_macchiato          = require('lualine_custom_theme').max_lualine_theme_macchiato
    local max_lualine_theme_mocha              = require('lualine_custom_theme').max_lualine_theme_mocha

    if vim.fn.has('gui_running') == 1 then
        if vim.g.colors_name == 'catppuccin-frappe' then
            require'lualine'.setup {options = { theme = max_lualine_theme_frappe }}
        elseif vim.g.colors_name == 'catppuccin-macchiato' then
            require'lualine'.setup {options = { theme = max_lualine_theme_macchiato }}
        elseif vim.g.colors_name == 'catppuccin-mocha' then
            require'lualine'.setup {options = { theme = max_lualine_theme_mocha }}
        elseif vim.g.colors_name == 'catppuccin-latte' then
            require'lualine'.setup {options = { theme = max_lualine_theme_latte }}
        end
    else
        if vim.g.colors_name == 'catppuccin-frappe' then
        require'lualine'.setup {options = { theme = max_lualine_theme_frappe_transparent }}
        elseif vim.g.colors_name == 'catppuccin-latte' then
        require'lualine'.setup {options = { theme = max_lualine_theme_latte_transparent }}
        end
    end
    end,
  },
-- }}}
-- {{{ dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
	keys = { { "<F12>", mode = { "n" }, ":StartupTime<CR>", desc = "StartupTime" } },
    init = function()
    vim.g.startuptime_tries = 10
    end,
  },
-- }}}
-- {{{ arecarn/vim-crunch
  {
    "arecarn/vim-crunch",
    keys = {
        { "<leader> ", mode = { "n" }, "<Plug>(crunch-operator-line)", { desc = 'Calculator' } },
        { "<leader> ", mode = { "x" }, "<Plug>(visual-crunch-operator)", { desc = 'Calculator' } },
    },
  },
-- }}}
-- {{{ sustech-data/wildfire.nvim
  {
    "sustech-data/wildfire.nvim",
    keys = { "<CR>" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("wildfire").setup({
            surrounds = {
                { "(", ")" },
                { "{", "}" },
                { "<", ">" },
                { "[", "]" },
            },
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<BS>",
            },
        })
    end,
  },
-- }}}
-- {{{ AndrewRadev/linediff.vim
  {
    "AndrewRadev/linediff.vim",
	keys = { { "<leader>dl", mode = { "n", "v" }, ":Linediff<CR>", desc = "[D]iff [L]ine" } },
  },
-- }}}
-- {{{ alpertuna/vim-header
  {
    "alpertuna/vim-header",
	keys = { { "<F10>", mode = { "n" }, ":AddHeader<CR>", desc = "Add Header" } },
    config = function()
    vim.g.header_field_author           = 'Max'
    vim.g.header_field_author_email     = 'ismaxiaolong@gmail.com'
    vim.g.header_field_timestamp_format = '%Y.%m.%d'
    vim.g.header_field_modified_by      = 0
    vim.g.header_field_license_id       = ''
    end,
  },
-- }}}
-- {{{ iqxd/vim-mine-sweeping
  -- { "iqxd/vim-mine-sweeping", cmd = "MineSweep" },
-- }}}
-- {{{ Yggdroot/LeaderF
  {
    "Yggdroot/LeaderF",
    build = ":LeaderfInstallCExtension",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Leaderf" },
    keys = {
        -- { "<leader>fs", mode = { "n" }, ":LeaderfFile :/<left><left>", desc = "File by Path" },
        -- { "<leader>fp", mode = { "n" }, "<cmd>Leaderf rg<cr>", desc = "Fuzzy word" },
        -- { "<leader>ff", mode = { "n" }, "<cmd>Leaderf file<cr>", desc = "[F]ile" },
        -- { "<leader>fg", mode = { "n" }, "<cmd>Leaderf git<cr>", desc = "[G]it" },
        -- { "<leader>fl", mode = { "n" }, "<cmd>Leaderf line<cr>", desc = "[L]ine" },
        -- { "<leader>fc", mode = { "n" }, "<cmd>Leaderf colorscheme<cr>", desc = "[C]olorscheme" },
        -- { "<leader>fh", mode = { "n" }, "<cmd>Leaderf searchHistory<cr>", desc = "Search [H]istory" },
        { "<localleader>T", mode = { "n" }, "<cmd>Leaderf bufTag<cr>", desc = "[T]ag" },
        { "<localleader>F", mode = { "n" }, "<cmd>Leaderf function<cr>", desc = "[F]unction" },
        { "<leader>fr", mode = { "n" }, "<cmd>Leaderf mru<cr>", desc = "[R]ecently Files" },
        { "<localleader>r", mode = { "n" }, "<cmd>Leaderf mru<cr>", desc = "[R]ecently Files" },
        -- { "<leader>fb", mode = { "n" }, "<cmd>Leaderf buffer<cr>", desc = "[B]uffer" },
        -- { "<leader>fq", mode = { "n" }, "<cmd>Leaderf quickfix<cr>", desc = "[Q]uickfix list" },
    },
    init = function()
    vim.g.Lf_ShortcutF = ""
    vim.g.Lf_ShortcutB = ""
    end,
    config = function()
    require('leaderf_PopupTheme_and_Icons')  -- 修改leaderf主题配色和icon
    vim.g.Lf_Ctags = vim.fn.exepath("ctags")
    vim.g.Lf_Rg = vim.fn.exepath("rg")
	vim.g.Lf_CursorBlink  = 0
    vim.g.Lf_ShowDevIcons = 1
    vim.g.Lf_SpacesAfterIcon = ' '
    vim.g.Lf_DevIconsFont = "Delugia Mono"
    vim.g.Lf_ReverseOrder = 1
    vim.g.Lf_HideHelp = 1
    vim.g.Lf_UseCache = 1
    vim.g.Lf_UseMemoryCache = 1
    vim.g.Lf_UseVersionControlTool = 0
    vim.g.Lf_IgnoreCurrentBufferName = 1
	vim.g.Lf_WorkingDirectoryMode = 'Ac'
	vim.g.Lf_DefaultMode = 'NameOnly'
    vim.g.Lf_PreviewCode = 1
    vim.g.Lf_PreviewInPopup = 1
    vim.g.Lf_StlSeparator = { left = "", right = "" }  -- left = "", right = ""
    vim.g.Lf_JumpToExistingWindow = 0
    vim.g.Lf_PreviewResult = {
        File        = 1,
        Buffer      = 0,
        Mru         = 0,
        Tag         = 0,
        BufTag      = 1,
        Function    = 1,
        Line        = 1,
        Colorscheme = 0,
        Rg          = 1,
        Gtags       = 0,
    }-- 0:不自动预览; 1:自动预览
    vim.g.Lf_NeedCacheTime = 0.1  -- cache the files list,if time > 0.1s.
    vim.g.Lf_CacheDirectory = vim.fn.has("unix") == 1
        and vim.fn.expand("~/.config/nvim/support/.cache")
        or "D:/Dotfiles/nvim/nvim/support/.cache"
    vim.g.Lf_MruMaxFiles = 2048
    vim.g.Lf_MruEnableFrecency = 0
    vim.g.Lf_ShowRelativePath = 1
    vim.g.Lf_WildIgnore = {
      dir = { ".svn", ".git", ".hg" },
      file = { "*.sw?", "~$*", "*.bak", "*.exe", "*.o", "*.so", "*.py[co]" },
    }
    -- 使用:LeaderfRg 路径不全时, 默认搜索该文件目录下的文件
    vim.cmd([[command! -bar -nargs=? -complete=dir LeaderfRg Leaderf! rg "" <q-args>]])

    -- 修改预览窗口移动,默认为<C-Up>和<C-Down>,修改为<C-b>和<C-f>,竖直分屏打开文件由<C-]>修改为<C-\>.
    -- 水平分屏打开文件为<C-x>, 竖直分屏为<c-\>, tab打开文件为<C-t>.
    vim.g.Lf_CommandMap = { ['<C-Up>'] = { '<C-b>' }, ['<C-Down>'] = { '<C-f>' }, ['<C-]>'] = { '<C-\\>' } }

    -- Bottom mode & Change statusline color (not popup mode)
    vim.g.Lf_WindowPosition = 'bottom'
    vim.api.nvim_set_hl(0, "Lf_hl_stlName",         { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlMode",         { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator0",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator1",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator2",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator3",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator4",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlSeparator5",   { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlLineInfo",     { link = "Statusline" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlRegexMode",    { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlFullPathMode", { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlFuzzyMode",    { link = "StatuslineNC" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlBlank",        { link = "Statusline" })
    vim.api.nvim_set_hl(0, "Lf_hl_stlTotal",        { link = "Statusline" })

    if vim.fn.has('gui_running') == 1 then
        if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg="#303446", fg="#429940", bold=true, italic=true } ) --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg="#303446", fg="#737994" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { fg="#b09a6f" } )                                            --4 domain
        elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg="#e1e2e7", fg="#8839ef", bold=true, italic=true } )  --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg="#e1e2e7", fg="#838ba7" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { bg="#e1e2e7", fg="#de6d78" } )                              --4 domain
        end
    else
        if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg=nil, fg="#429940", bold=true, italic=true } ) --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg=nil, fg="#737994" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { bg=nil, fg="#b09a6f" } )                              --4 domain
        elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
            vim.api.nvim_set_hl(0, "Lf_hl_stlCategory",     { bg=nil, fg="#8839ef", bold=true, italic=true } ) --2 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlNameOnlyMode", { bg=nil, fg="#838ba7" } )                      --3 domain
            vim.api.nvim_set_hl(0, "Lf_hl_stlCwd",          { bg=nil, fg="#de6d78" } )                              --4 domain
        end
    end
    end,
  },
-- }}}
-- {{{ voldikss/vim-floaterm
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermSend" },
    config = function()
        if vim.o.background == 'dark' then
            vim.api.nvim_set_hl(0, "FloatermBorder", { fg = "#89a0c3", bg = "#303446" })
        elseif vim.o.background == 'light' then
            vim.api.nvim_set_hl(0, "FloatermBorder", { fg = "#40a02b", bg = "#e1e2e7" })
        end
    end,
    init = function()
        vim.g.floaterm_wintype = 'float'
        vim.g.floaterm_title = '─────  Terminal [$1|$2] '
        vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
        vim.g.floaterm_autoclose = 0
        vim.g.floaterm_keymap_kill = '<C-q>'
        vim.g.floaterm_keymap_next = '<leader>tn'
        vim.g.floaterm_shell = vim.fn.has("unix") == 1
            and "/bin/bash"
            or "C:/PROGRA~1/PowerShell/7/pwsh.exe"
        -- 从':terminal '中打开外部nvim中的文件的命令。
        vim.g.floaterm_opener = 'edit'  -- 'edit', 'split', 'vsplit', 'tabe', 'drop'
        neomap("n","<leader>to",":FloatermNew --position=center --width=0.9 --height=0.9<CR>", { desc = 'New Term' })
        -- neomap("n","<localleader>e",":FloatermNew! --position=center --width=0.9 --height=0.9 --autoclose=1 lfcd<CR>") --slower
        -- neomap("n","<localleader>e",":FloatermNew --position=center --width=0.9 --height=0.9 --autoclose=1 lfcd<CR>") --faster
        -- neomap("n","<localleader>e",":FloatermNew --position=center --width=0.99 --height=0.99 --autoclose=1 yazi<CR>", { desc = 'Yazi' }) --faster
        neomap("n","<leader>tt",":FloatermToggle<CR>", { desc = '[T]oggle Term' })
        neomap("n","<leader>tr",":FloatermNew<CR>rg.exe<Space>" , { desc = '[R]g' })
        neomap('n', '<M-o>', ':FloatermNew SumatraPdf <C-r><C-l><CR>', {})
        -- Lazygit. 首先在系统安装'jesseduffield/lazygit'
        -- lazygit的配置文件'C:\Users\ThinkPad\AppData\Roaming\lazygit\config.yml'
        neomap("n","<leader>gg",":FloatermNew --position=center --width=0.99 --height=0.99 --autoclose=1 Lazygit<CR>", { desc = 'Lazy[G]it' }) --faster
        neomap("n","<leader>tj",":FloatermNext<CR>", { desc = 'Next Term' } )
        neomap("n","<leader>tk",":FloatermPrev<CR>", { desc = 'Prev Term' } )

        vim.cmd[[
        augroup Compiler_code
        au!
        au FileType floaterm nnoremap <buffer> <Esc> :q<CR>
        " -- Python --
        au FileType python nnoremap <silent><C-CR> :FloatermNew --width=0.8 --height=1.0 py "%:p"<CR>
        " au FileType python nnoremap <C-g> :FloatermNew py "%:p"<CR>
        au FileType python noremap! <C-CR>  <Esc>:FloatermToggle<CR>
        " au FileType python noremap! <C-g>  <Esc>:FloatermToggle<CR>
        " au FileType python tnoremap <C-CR>  <C-\><C-n>:FloatermToggle<CR>
        " -- Python REPL --
        nnoremap <leader>tp :FloatermNew --width=0.5 --wintype=vsplit --name=repl --position=rightbelow ipython<CR>
        au FileType python nnoremap <leader>w :FloatermSend<CR>
        au FileType python vnoremap <leader>w :FloatermSend<CR>
        " -- Matlab --
        au FileType matlab nnoremap <silent><C-CR> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
        " au FileType matlab nnoremap <silent><C-g> :! matlab -nosplash -nodesktop -r %:r<CR><CR>
        " TERMINAL运行matlab代码,以'test.m'代码为例 'matlab -nosplash -nodesktop -r test'
        " -- Fortran --
        au FileType fortran nnoremap <silent><C-CR> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
        " au FileType fortran nnoremap <C-g> :FloatermNew<CR>compilervars.bat intel64<CR>ifort<Space>
        " -- Typst --
        " highligth file 'D:\Program Files\Neovim\share\nvim\runtime\syntax\typst.vim'
        au BufRead,BufNewFile *.typ setlocal filetype=typst
        au FileType typst nnoremap <silent><C-CR> :FloatermNew --height=1.0 typst watch %:p<CR>
        " au FileType typst nnoremap <C-g> :FloatermNew --height=1.0 typst watch %:p<CR>

        " au FileType typst command! TypstPDF execute "FloatermNew! sumatrapdf %:p<C-h><C-h><C-h>pdf<CR>"
        au FileType typst nnoremap <silent> <M-v> :call jobstart(['sumatrapdf', expand('%:r') . '.pdf'], {'detach': v:true})<CR>

        augroup END
        " Git
        command! Push execute "FloatermNew!git add init.lua<CR>git commit --allow-empty-message -m \"\"<CR>git push<CR>"
        command! Pull execute "FloatermNew!git fetch --all<CR>git reset --hard origin/main<CR>"
        command! Gitlog execute "FloatermNew!git log --all --oneline --graph<CR>"
        " Administrator CMD mode
        nnoremap  <leader>ta  :FloatermNew<CR>runas /user:ThinkPad\Administrator cmd<CR>1234<CR>
        " nnoremap  <leader>ta  :FloatermNew<CR>runas /user:administrator cmd<CR>1234<CR>
        " 'runas /user:administrator cmd' 进入管理员CMD的前提是开启管理员账号
        " 开启管理员账号: net user administrator /active:yes
        " 关闭管理员账号: net user administrator /active:no
        " 设置管理员密码(1234): net user administrator 1234
        ]]
    end,
  },
-- }}}
-- {{{ iamcco/markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
    vim.g.mkdp_auto_close = 0
    --设置预览代码高亮(绝对路径)
    if vim.fn.has("unix") == 1 then
        vim.g.mkdp_markdown_css = "~/.config/nvim/support/github-markdown.css"
        vim.g.mkdp_highlight_css = "~/.config/nvim/support/markdown.css"
    else
        vim.g.mkdp_markdown_css = "D:/Dotfiles/nvim/nvim/support/github-markdown.css"
        vim.g.mkdp_highlight_css = "D:/Dotfiles/nvim/nvim/support/markdown.css"
        -- vim.g.mkdp_highlight_css = "D:/Dotfiles/nvim/nvim/support/markdown_highlight_solarized_dark.css"
    end
    vim.g.mkdp_theme = 'light'  --'dark', 若不设置则和系统一致
    vim.cmd[[
    augroup markdown_preview
        au!
        au FileType markdown nnoremap <silent><C-CR> <Plug>MarkdownPreview
    augroup END
    ]]
    end,
  },
-- }}}
-- {{{ OXY2DEV/markview.nvim
  {
    "OXY2DEV/markview.nvim",
    ft = {"markdown", "typst"},
    opts = {
      typst = {
        symbols = { enable = false },          -- 数学符号（β、∑、∇ 等）
        subscripts = { enable = false },       -- 下标
        superscripts = { enable = false },     -- 上标
        math_blocks = { enable = false },      -- 块公式
        math_spans = { enable = false },       -- 行内公式
        reference_links = { enable = false },  -- 文献/标签引用
      },
    },
  },
-- }}}
-- {{{ chomosuke/typst-preview.nvim
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    keys = {
        { "<leader>p", "<cmd>TypstPreview<CR>", ft = "typst", desc = "typst-preview" },
    },
    config = function()
        require("typst-preview").setup {
            invert_colors = 'never',  -- never, always, auto
            dependencies_bin = {
                tinymist = vim.fn.has("win32") == 1 and 'tinymist.cmd' or 'tinymist',
            },
        }
        if vim.fn.has("win32") == 1 then
            local typst_utils = require("typst-preview.utils")
            typst_utils.visit = function(link)
                vim.fn.jobstart({"explorer.exe", "http://" .. link})
            end
        end
    end,
  },
-- }}}
-- {{{ phanen/skip-conceal.nvim  note: 在conceallevel=2时避免光标停留在conceal掉的字符上
  {
    "phanen/skip-conceal.nvim",
    ft = "markdown",
  },
-- }}}
-- {{{ lervag/vimtex
  { "lervag/vimtex",
    ft = {"tex", "latex", "bib"},
    keys = {
        { "<localleader>li", "<plug>(vimtex-info)", mode = "n" },
        { "<localleader>lt", "<plug>(vimtex-toc-open)", mode = "n" },
        { "<localleader>lT", "<plug>(vimtex-toc-toggle)", mode = "n" },
        { "<localleader>lv", "<plug>(vimtex-view)", mode = "n" },
        { "<localleader>ll", "<plug>(vimtex-compile)", mode = "n", desc = 'Compile' },
        { "<localleader>lo", "<plug>(vimtex-compile-output)", mode = "n" },
        { "<localleader>lg", "<plug>(vimtex-status)", mode = "n" },
        { "<localleader>lG", "<plug>(vimtex-status-all)", mode = "n" },
        { "<localleader>lc", "<plug>(vimtex-clean)", mode = "n" },
        { "<localleader>lC", "<plug>(vimtex-clean-full)", mode = "n" },
    },
    config = function()
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_quickfix_mode = 1
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_view_reverse_search_edit_cmd = "nvr --remote-silent %f -c %l"
    vim.g.vimtex_compiler_latexmk = {
      continuous = 0, -- 1: save file auto compile and preview
    }
    vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" } --{["_"] = "-lualatex"}
    vim.g.vimtex_view_automatic = 1
    vim.g.vimtex_indent_on_ampersands = 0
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
    vim.g.vimtex_fold_enabled = true
    -- Using Treesitter requires these settings
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_syntax_conceal_disable = 1
    -- neovim ---(highlight)---> pdf by 'lv'
    function Open_sumatra_pdf()
        local pdf_file = vim.fn.expand('%:r') .. '.pdf'
        if vim.fn.filereadable(pdf_file) == 0 then
          pdf_file = ""
        end
        local cmd = 'cmd /c start /b "" SumatraPDF -reuse-instance ' .. pdf_file
        os.execute(cmd)
    end
    vim.api.nvim_create_autocmd({"BufReadPost"}, {
      pattern = {"*.tex", "*.latex"},
      callback = Open_sumatra_pdf,
    })
    -- Disable conceal
    vim.g.vimtex_syntax_conceal = {
        accents = 0,
        cites = 0,
        fancy = 0,
        greek = 0,
        math_bounds = 0,
        math_delimiters = 0,
        math_fracs = 0,
        math_super_sub = 0,
        math_symbols = 0,
        sections = 0,
        styles = 0,
    }
    end,
  },
-- }}}
-- {{{ wellle/targets.vim
  { "wellle/targets.vim", keys = { "c", "d", "y", "v"} },
-- }}}
-- {{{ chrisbra/csv.vim
  { "chrisbra/csv.vim", ft = "csv" },
-- }}}
-- {{{ ntpeters/vim-better-whitespace
  {
    "ntpeters/vim-better-whitespace",
    event = "InsertEnter",
	keys = { { "<leader>si", mode = { "n" }, ":StripWhitespace<CR>", desc = "WhiteSpace" } },
    config = function()
    vim.g.better_whitespace_guicolor='red'
    vim.g.strip_whitespace_on_save=0
    vim.g.better_whitespace_filetypes_blacklist = {
                'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown',
                'startify', 'snacks_dashboard'
    }
    end,
  },
-- }}}
-- {{{ lfv89/vim-interestingwords
  {
    "lfv89/vim-interestingwords",
    keys = {
        { "<leader>k", ":call InterestingWords('n')<cr>", mode = { "n" }, desc = 'Toggle Color Word(n)' },
        { "<leader>k", ":call InterestingWords('v')<cr>", mode = { "v" }, desc = 'Toggle Color Word(v)' },
        { "<leader>K", ":call UncolorAllWords()<cr>", mode = { "n" }, desc = 'Uncolor all Word' },
    },
    config = function()
    vim.g.interestingWordsGUIColors = {
                '#78d3cc', '#f0c53f', '#ff8784', '#c5c7f1',
                '#c2d735', '#72b5e4', '#ea8336', '#e43542',
                '#ebab35', '#ebe735', '#aadd32', '#dcca6b',
                '#219286', '#2f569c', '#ffb577', '#5282a4',
                '#edfccf', '#67064c', '#f5bca7', '#95c474',
                '#dece83', '#de9783', '#f2e700', '#e9e9e9',
                '#69636d', '#626b98', '#f5f5a7', '#dcca6b',
                '#b72a83', '#6f2b9d', '#69636d', '#5f569c',
    }
    end,
  },
-- }}}
-- {{{ markonm/traces.vim
  {
    "markonm/traces.vim",
    event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
    config = function()
    vim.g.traces_normal_preview = 1
    vim.g.traces_num_range_preview = 1
    end,
  },
-- }}}
-- {{{ triglav/vim-visual-increment
  {
    "triglav/vim-visual-increment",
    event = "InsertEnter",
    config = function()
    vim.cmd[[set nrformats=alpha,octal,hex]]
    end,
  },
-- }}}
-- {{{ sontungexpt/stcursorword
  { "sontungexpt/stcursorword", event = "BufReadPre", config = true },
-- }}}
-- {{{ alvarosevilla95/luatab.nvim
  {
    "alvarosevilla95/luatab.nvim",
    event = "BufReadPre",
    config = function()
    require('luatab').setup{
    	separator = function()
    		return ""
    	end,
        windowCount = function(index) -- 显示buffer数字
            return index .. ' '
        end,
        --windowCount = function() -- 不显示buffer数字
        --  return ""
        --end,
        modified = function(bufnr)
            return vim.fn.getbufvar(bufnr, '&modified') == 1 and '[+] ' or ''  -- '[+] ', '● ', '🈚 ', ' '
        end,
        title = function(bufnr)
            local file = vim.fn.bufname(bufnr)
            local buftype = vim.fn.getbufvar(bufnr, '&buftype')
            local filetype = vim.fn.getbufvar(bufnr, '&filetype')

            if buftype == 'help' then
                return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
            elseif buftype == 'quickfix' then
                return 'quickfix'
            elseif filetype == 'TelescopePrompt' then
                return 'Telescope'
            elseif buftype == 'terminal' then
                local _, mtch = string.match(file, "term:(.*):(%a+)")
                return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
            elseif file == '' then
                return '[No Name]'
            else
                return vim.fn.fnamemodify(file, ':p:h:t') .. '/' .. vim.fn.fnamemodify(file, ':t')
            end
        end
    }
    end,
  },
-- }}}
-- {{{ folke/snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      -- snacks_dashboard color
      vim.api.nvim_set_hl(0, 'NeovimDashboardLogo1', { fg = '#5b3cc4' })
      vim.api.nvim_set_hl(0, 'NeovimDashboardLogo2', { fg = '#7b4fd6' })
      vim.api.nvim_set_hl(0, 'NeovimDashboardLogo3', { fg = '#9d6ff0' })
      vim.api.nvim_set_hl(0, 'NeovimDashboardLogo4', { fg = '#c77dff' })
      vim.api.nvim_set_hl(0, 'NeovimDashboardLogo5', { fg = '#e38fff' })
    end,
    opts = {
        picker = {
            enabled = true,
            win = {
                input = {
                    keys = {
                        ["\\"] = { "edit_vsplit", mode = { "i", "n" } },
                        ["|"] = { "edit_split", mode = { "i", "n" } },
                        ["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
                    },
                },
            },
            },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        indent = {
            enabled = true,
            indent = {
                char = "¦", -- | ¦ ┆ ┊ │ 
                hl = "LineNr",
            },
            animate = { enabled = false },
            scope = { enabled = true, hl = "LineNr", char = "│" },
            chunk = {
                enabled = true,
                char = {
                    corner_top = "╭",
                    corner_bottom = "╰",
                    horizontal = "─",
                    vertical = "│",
                    arrow = ">",
                },
            },
            blank = {
                char = ' ',
            },
        },
        dashboard = {
                enabled = true,
                preset = {
                  keys = {
                    { icon = "  ", key = "i", desc = "New File", action = ":ene | startinsert" },
                    -- { icon = "  ", key = "f", desc = "Find File", action = ":Leaderf file" },
                    { icon = "  ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "  ", key = "s", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "  ", key = "r", desc = "Recently Files", action = ":Leaderf mru" },
                    { icon = "💤 ", key = "l", desc = "Manage Plugins", action = ":Lazy", enabled = package.loaded.lazy ~= nil },  --  鈴💤
                    { icon = "  ", key = "d", desc = "Dotfiles", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = "  ", key = "q", desc = "Quit", action = ":qa" },  --  
                  },
                },
                sections = {
                  { text = { [[     ▄████▄              ▒▒▒▒▒       ▒▒▒▒▒       ]], hl = 'NeovimDashboardLogo1' }, align = 'center' }, ---@diagnostic disable-line
                  { text = { [[    ███▄█▀              ▒ ▄▒ ▄▒     ▒ ▄▒ ▄▒      ]], hl = 'NeovimDashboardLogo2' }, align = 'center' }, ---@diagnostic disable-line
                  { text = { [[   ▐████     █  █  █   ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒     ]], hl = 'NeovimDashboardLogo3' }, align = 'center' }, ---@diagnostic disable-line
                  { text = { [[    █████▄             ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒     ]], hl = 'NeovimDashboardLogo4' }, align = 'center' }, ---@diagnostic disable-line
                  { text = { [[     ▀████▀            ▒ ▒ ▒ ▒ ▒   ▒ ▒ ▒ ▒ ▒    ]], hl = 'NeovimDashboardLogo5' }, align = 'center' }, ---@diagnostic disable-line
                  { text = { [[                                                 ]], hl = 'NeovimDashboardLogo1' }, align = 'center' }, ---@diagnostic disable-line
                  { padding = 1 },
                  -- { section = "header" },
                  { section = 'keys', gap = 1, padding = 1 },
                  { section = 'startup' },
                },
        },
    },
    keys = {
        { "<leader>ff", ":lua Snacks.picker.files()<CR>",   mode = { "n" }, desc = '[F]ile' },
        { "<leader>fs", ":lua Snacks.picker('live_grep')<CR>", mode = { "n" }, desc = 'Fuzzy word' },
        { "<leader>fc", ":lua Snacks.picker.colorschemes()<CR>", mode = { "n" }, desc = "Colorschemes" },
        { "<leader>fl", ":lua Snacks.picker.lines()<CR>", mode = { "n" }, desc = "[L]ine" },
        -- { "<leader>fh", ":lua Snacks.picker.search_history()<CR>", mode = { "n" }, desc = "Search [H]istory" },
        { "<leader>fh", ":lua Snacks.picker.help()<CR>", mode = { "n" }, desc = "Search in [H]elp" },
        { "<leader>fg", ":lua Snacks.picker.git_diff()<CR>", mode = { "n" }, desc = "[G]it diff" },
        { "<leader>fk", ":lua Snacks.picker.keymaps()<CR>", mode = { "n" }, desc = "[K]eymaps" },
    },
  },
-- }}}
-- {{{ windwp/nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})
        local Rule = require("nvim-autopairs.rule")
        require("nvim-autopairs").add_rule(Rule("$", "$", "typst"))
    end
  },
-- }}}
-- {{{ karb94/neoscroll.nvim
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    config = function()
    local neoscroll = require('neoscroll')
    local scroll_keymap = {
      ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 45; easing = 'sine' }) end;
      ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 45; easing = 'sine' }) end;
      ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 90; easing = 'circular' }) end;
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 90; easing = 'circular' }) end;
      ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 20 }) end;
      ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 20 }) end;
      ["zt"]    = function() neoscroll.zt({ half_win_duration = 90 }) end;
      ["zz"]    = function() neoscroll.zz({ half_win_duration = 90 }) end;
      ["zb"]    = function() neoscroll.zb({ half_win_duration = 90 }) end;
    }
    local scroll_modes = { 'n', 'v', 'x' }
    for key, func in pairs(scroll_keymap) do
      vim.keymap.set(scroll_modes, key, func)
    end
    end,
  },
-- }}}
-- {{{ dstein64/nvim-scrollview
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPre",
    keys = {
        { "]]", "<Cmd>ScrollViewNext<cr>",  mode = { "n" }, desc = "Next sign" },
        { "[[", "<Cmd>ScrollViewPrev<cr>",  mode = { "n" }, desc = "Prev sign" },
        { "[\\", "<Cmd>ScrollViewFirst<cr>", mode = { "n" }, desc = "First sign" },
        { "]\\", "<Cmd>ScrollViewLast<cr>",  mode = { "n" }, desc = "Last sign" },
    },
    config = function()
    require("scrollview").setup {
      excluded_filetypes = { 'snacks_dashboard', 'neo-tree','mason','floaterm' },
      winblend = 50,
      -- signs_on_startup = {'all'},
      signs_on_startup = {
          "conflicts",
          "cursor",
          "diagnostics",
          "folds",
          "loclist",
          "marks",
          "quickfix",
          "search",
          "spell",
          -- "textwidth",
          -- "trail",
      },

      -- cursor_symbol = "•",

      diagnostics_error_symbol = '',  --󰨓
      diagnostics_warn_symbol  = '',  --󰨓
      diagnostics_hint_symbol  = '',  --󰨓
      diagnostics_info_symbol  = '',  --󰨓
    }

    -- 自定义显示的diagnostics icon
    vim.g.scrollview_diagnostics_severities = {
      vim.diagnostic.severity.ERROR,
      -- vim.diagnostic.severity.WARN,
      -- vim.diagnostic.severity.INFO,
      -- vim.diagnostic.severity.HINT,
    }

    require("scrollview.contrib.gitsigns").setup {
      add_priority = 100,
      change_priority = 100,
      delete_priority = 100,
      -- add_symbol = '│',
      -- change_symbol = '│',
      -- delete_symbol = '_',
    }
    vim.api.nvim_set_hl(0, "ScrollViewHover", { link = "Search" })
    end,
  },
-- }}}
-- {{{ kevinhwang91/nvim-hlslens
  {
    "kevinhwang91/nvim-hlslens",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
    require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
            local sfw = vim.v.searchforward == 1
            local indicator, text, chunks
            local absRelIdx = math.abs(relIdx)
            if absRelIdx > 1 then
                indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
            elseif absRelIdx == 1 then
                indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
            else
                indicator = ''
            end

            local lnum, col = unpack(posList[idx])
            if nearest then
                local cnt = #posList
                if indicator ~= '' then
                    text = ('[%s %d/%d]'):format(indicator, idx, cnt)
                else
                    text = ('[%d/%d]'):format(idx, cnt)
                end
                chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
            else
                text = ('[%s %d]'):format(indicator, idx)
                chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
            end
            render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
    })
    --mapping
    -- vim.cmd[[nnoremap <leader>/ /\<<C-R>=expand("<cword>")<CR>\><left><left>]]
    neomap('n', "<leader>/", [[:/\<<C-R>=expand("<cword>")<CR>\><left><left>]], { desc = 'Search <Pattern>' })
    --color
    if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#d73a4a", bold = true })
        vim.api.nvim_set_hl(0, "CurSearch", { fg = "#000000", bg = "#d73a4a", bold = true }) -- set hlslens color
    elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#e78284", bold = true })
        vim.api.nvim_set_hl(0, "CurSearch", { fg = "#000000", bg = "#e78284", bold = true }) -- set hlslens color
    end
    end,
  },
-- }}}
-- {{{ b3nj5m1n/kommentary
  {
    "b3nj5m1n/kommentary",
    keys = {
        { "<leader>cc", "<Plug>kommentary_line_increase",   mode = { "n" }, desc = '[C]omment' },
        { "<leader>cc", "<Plug>kommentary_visual_increase", mode = { "x" }, desc = '[C]omment' },
        { "<leader>ci", "<Plug>kommentary_line_decrease",   mode = { "n" }, desc = 'Uncomment' },
        { "<leader>ci", "<Plug>kommentary_visual_decrease", mode = { "x" }, desc = 'Uncomment' },
    },
    config = function()
    require('kommentary.config').configure_language({"lua"}, {
      prefer_single_line_comments = true,
    })
    vim.g.kommentary_create_default_mappings = false
    end,
  },
-- }}}
-- {{{ kyazdani42/nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
    -- 设置icon (lualine, neo-tree, Oil)
    require('nvim_web_devicons_edit_icons')
    end,
  },
-- }}}
-- {{{ nvim-mini/mini.align
  {
    "nvim-mini/mini.align",
    version = "*",
    keys = {
        { mode = { 'x' }, '<leader>a', desc = '[A]lign' },
        { mode = { 'x' }, '<leader>A', desc = 'Interactive [A]lign' },
    },
    config = function()
        require('mini.align').setup({
            mappings = {
                start = '<leader>a',
                start_with_preview = '<leader>A',
            },
        })
    end,
  },
-- }}}
-- {{{ oil.nvim + oil-git-status.nvim
  {
    'stevearc/oil.nvim',
    keys = {
        -- { '<leader>e', function() require('oil').toggle_float() end, mode = 'n', desc = "Oil File Explorer", },
        {
          "<leader>e",
          function()
              if vim.bo.filetype == "oil" then
                  require("oil.actions").close.callback()
              else
                  vim.cmd("Oil")
              end
          end,
          mode = "n",
          desc = "Oil File Explorer"
        },
     },
    cmd = "Oil",
    opts = {},
    dependencies = {
        { "kyazdani42/nvim-web-devicons" },
        { "refractalize/oil-git-status.nvim" },
    },
    -- lazy = false,
    config = function()

    function _G.get_oil_winbar()   -- 显示当前目录
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = require("oil").get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ":~")
      else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
      end
    end

    local oil_detail = false
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      use_default_keymaps = false,
      view_options = {
        show_hidden = false,
        natural_order = "fast",
      },
      win_options = {
        wrap = true,
        signcolumn = "yes:1",  -- 隐藏了git的index,只显示git的working_tree,1就够了
        winbar = "%!v:lua.get_oil_winbar()",
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["\\"] = { "actions.select", opts = { vertical = true } },
        ["|"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        ["<C-r>"] = "actions.refresh",
        ["<BS>"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        -- ["`"] = { "actions.cd", mode = "n" },
        -- ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            oil_detail = not oil_detail
            if oil_detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
    })
    require("oil-git-status").setup({
        show_ignored = true, -- show files that match gitignore with !!
         symbols = { -- customize the symbols that appear in the git status columns
           index = {
			 ["!"] = "", -- ignored
			 ["?"] = "", -- untracked
			 -- ["A"] = "", -- added
			 -- ["C"] = "", -- copied
			 -- ["D"] = "", -- deleted
			 ["M"] = "", -- modified
			 -- ["R"] = "", -- renamed
			 -- ["T"] = "", -- type changed
			 -- ["U"] = "", -- unmerged
			 [" "] = "", -- clean
           },
           working_tree = {
			 ["!"] = "󰘓", -- ignored
			 ["?"] = "", -- untracked
			 -- ["A"] = "", -- added
			 -- ["C"] = "○", -- copied
			 -- ["D"] = "○", -- deleted
			 ["M"] = "", -- modified
			 -- ["R"] = "→", -- renamed
			 -- ["T"] = "○", -- type changed
			 -- ["U"] = "○", -- unmerged
			 [" "] = "✓", -- clean
           },
         },
    })
    vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeUnmodified", { fg = "#6cc749" })
    vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeIgnored", { fg = "#7f848e" })
    vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeUntracked", { fg = "#e5c07b" })
    vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeAdded", { fg = "#98c379" })
    vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeModified", { fg = "#ec613f" })
    vim.api.nvim_set_hl(0, "OilGitStatusWorkingTreeRenamed", { fg = "#61afef" })
    end
  },
-- }}}
-- {{{ kylechui/nvim-surround
  { "kylechui/nvim-surround",
    keys = {
        -- 触发 + 保持默认 ys/cs/ds 行为
        { mode = "n", "ys" },  --ysiw
        { mode = "n", "cs" },  -- css
        { mode = "n", "ds" },  -- dss

        -- Visual 模式用 <C-s> 包裹选中内容
        { mode = "x", "<C-s>", "<Plug>(nvim-surround-visual)", remap = true },

        -- 快捷包裹当前单词
        { mode = "n", "))", "ysiw)", remap = true, desc = "Surround word with ()"},
        { mode = "n", "((", "ysiw)", remap = true, desc = "Surround word with ()"},
        { mode = "n", "}}", "ysiw}", remap = true, desc = "Surround word with {}"},
        { mode = "n", '""', 'ysiw"', remap = true, desc = 'Surround word with ""'},
        { mode = "n", "''", "ysiw'", remap = true, desc = "Surround word with ''"},
        -- { mode = "n", "]]", "ysiw]", remap = true},
    },
    config = function()
    require("nvim-surround").setup()
    end,
  },
-- }}}
-- {{{ folke/flash.nvim
  {
    "folke/flash.nvim",
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "f", mode = { "n" } },
        { "F", mode = { "n" } },
        { "t", mode = { "n" } },
        { "T", mode = { "n" } },
        -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	opts = {
        jump = {
            -- automatically jump when there is only one match
            autojump = false,
        },
		label = {
            after = { 0, 0 },
			rainbow = {
                enabled = true,
                shade = 3,
            },
		},
		modes = {
            -- `f`, `F`, `t`, `T`, `;` and `,` motions
            char = {
                enabled = true,
                jump_labels = true,
                autohide = true,
                char_actions = function()
                  return {
                    [";"] = "right", -- set to `right` to always go right
                    [","] = "left", -- set to `left` to always go left
                  }
                end,
            },
            -- a regular search with `/` or `?`
			search = {
				enabled = false,
			},
		},
	},
  },
-- }}}
-- {{{ catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
    local transparent_TREM
    if vim.fn.has('gui_running') == 1 then
        transparent_TREM = false
    else
        -- transparent_TREM = true
        transparent_TREM = false
    end
    require("catppuccin").setup({
        transparent_background = transparent_TREM,
        term_colors = true,
        styles = {
            comments = {},
            conditionals = { "italic" },
            loops = {},
            functions = { "italic" },
            keywords = { "bold" },
            strings = {},
            variables = {},
            numbers = { "italic" },
            booleans = {},
            properties = {},
            types = { "italic", "bold" },
            operators = {},
        },
        color_overrides = {
                    latte = {
                        base = '#e1e2e7',
                        mantle = "#e1e2e7",
                    },
                    frappe = {
                        text   = "#abb2bf",
                        mantle = "#303446",
                    },
                    macchiato = {
                        text   = "#abb2bf",
                        mantle = "#24273A",
                    },
                    mocha = {
                        text     = "#abb2bf",
                        subtext1 = "#DEBAD4",
                        subtext0 = "#C8A6BE",
                        overlay2 = "#B293A8",
                        overlay1 = "#9C7F92",
                        overlay0 = "#866C7D",
                        surface2 = "#705867",
                        surface1 = "#5A4551",
                        surface0 = "#44313B",
                        base     = "#352939",
                        mantle   = "#352939", --origin "#1E1E2E"
                        crust    = "#1a1016",
                    },
        },
        custom_highlights = {},
        integrations = {
            -- blink_cmp = true,
            snacks = true,
            snacks_dashboard = true,
            gitsigns = true,
            flash = true,
            markdown = true,
            mason = true,
            neotree = true,
            treesitter = true,
            treesitter_context = true,
            rainbow_delimiters = true,
            which_key = true,
        },
    })
    end,
  },
-- }}}
-- {{{ norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
	keys = { { "<leader>co", mode = { "n" }, "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" } },
    config = function() require'colorizer'.setup() end,
  },
-- }}}
-- {{{ nvim-orgmode/orgmode
  {
    "nvim-orgmode/orgmode",  -- orgmode 会自动安装org parser,无需设置nvim-treesitter安装org
    ft = "org",
    -- commit = "b0c9896",  -- 最新commit: 1ab7b45
    dependencies = {
        {
          "akinsho/org-bullets.nvim",
          ft = "org",
          config = function()
          require('org-bullets').setup({
              show_current_line = false,
              concealcursor = true,
              indent = true,
              symbols = {
                  list = "•",
                  headlines = { "⦿", "●", "◈", "◆", "◇", "▶", "○", "⤷" },  -- neorg level1: ◉⦿
                  --  { "◉", "○", "✸", "✺", "♦", "▶", "◇", "⤷" }, {"🌸","🌱","💧","✨","💗" }, ♠, ♣, ♦, ❀, ▼,󰼏󰎨󰼑󰎲󰼓󰎴
                  checkboxes = {
                      cancelled = { '', 'OrgCancelled' },
                      half = { '', 'OrgTSCheckboxHalfChecked' },  --   
                      done = { '', 'OrgDone' },--✓
                      todo = { '', 'OrgTODO' },--×
                  },
              },
          })
          end,
        },
        {
        "hamidi-dev/org-list.nvim",
        dependencies = { 'tpope/vim-repeat' },  -- for repeatable actions with '.'
        config = function()
          require("org-list").setup({
            mapping = {
              -- key = "<leader>o-",  -- nvim-orgmode users: you might want to change this to <leader>olt
              key = "<localleader>a",  -- nvim-orgmode users: you might want to change this to <leader>olt
              desc = "Toggle: Cycle through list types"
            },
            checkbox_toggle = {
              enabled = true,
              key = "<Cr>",
              desc = "Toggle checkbox state",
              filetypes = { "org", "markdown" }  -- Add more filetypes as needed
            }
          })
        end
        },
    },

    config = function()
        local orgmode = require('orgmode')
        local org_dir = vim.fn.has("unix") == 1
            and vim.fn.expand("~/.config/nvim/support/Org")
            or "D:/Dotfiles/nvim/nvim/support/Org"

    orgmode.setup({
       org_agenda_files = org_dir .. '/**/*',
       org_default_notes_file = org_dir .. '/index.org',
       org_hide_leading_stars = true,
       org_hide_emphasis_markers = true,
       org_todo_keywords = { 'TODO(t)', 'WAITING', 'IN-PROGRESS', '|', 'DONE(d)', 'CANCELLED' },
       org_todo_keyword_faces = {
           ['TODO'] = ':background cyan :foreground black',
           ['WAITING'] = ':background darkyellow :foreground black',
           ['IN-PROGRESS'] = ':background coral :foreground black',
           ['DONE'] = ':background chartreuse :foreground black',
           ['CANCELLED'] = ':background red :foreground black',
       },
       mappings = {
           org = {
               org_change_date = 'cid',
               org_todo = 'cit',
               org_agenda_show_help = 'g?',  -- show help
               org_toggle_checkbox = '<cr>',
           },
       },
    })
    vim.api.nvim_set_hl(0, "@org.checkbox",             { fg = "#f23f42" })
    vim.api.nvim_set_hl(0, "@org.checkbox.halfchecked", { fg = "#0AC40A" })
    vim.api.nvim_set_hl(0, "@org.checkbox.checked",     { fg = "#0AC40A" })
    -- org-colors-doom-molokai
    vim.api.nvim_set_hl(0, "@org.headline.level1", { fg = "#fb2874" })
    vim.api.nvim_set_hl(0, "@org.headline.level2", { fg = "#fd971f" })
    vim.api.nvim_set_hl(0, "@org.headline.level3", { fg = "#9c91e4" })
    vim.api.nvim_set_hl(0, "@org.headline.level4", { fg = "#268bd2" })
    vim.api.nvim_set_hl(0, "@org.headline.level5", { fg = "#e74c3c" })
    vim.api.nvim_set_hl(0, "@org.headline.level6", { fg = "#b6e63e" })
    vim.api.nvim_set_hl(0, "@org.headline.level7", { fg = "#66d9ef" })
    vim.api.nvim_set_hl(0, "@org.headline.level8", { fg = "#e2c770" })
    end,
    init = function()
        vim.cmd([[au FileType org setlocal nofoldenable]])
    
        if vim.fn.has("unix") == 1 then
            neomap("n", "<leader>od", ":Oil ~/.config/nvim/support/Org/<CR>", { desc = 'Org [D]irectories' })
        else
            neomap("n", "<leader>od", ":Oil D:/Dotfiles/nvim/nvim/support/Org/<CR>", { desc = 'Org [D]irectories' })
        end
    end,
  },
-- }}}
-- {{{ nvzone/showkeys
  {
   "nvzone/showkeys",
   cmd = "ShowkeysToggle",
   opts = {
       maxkeys = 5,
       position = 'top-center',  -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
   },
  },
-- }}}

-- {{{ nvim-treesitter/nvim-treesitter --- kickstart
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- event = { 'BufReadPost', 'BufNewFile', 'BufReadPre' },
    dependencies = {
        "hiphish/rainbow-delimiters.nvim",
    },
    config = function()
      local parsers = { 'bash', 'python', 'fortran', 'c', 'vim', 'vimdoc', 'query', 'lua', 'bibtex', 'markdown', 'matlab', 'json', 'toml', 'yaml', 'typst', 'ini', 'latex' }
      require('nvim-treesitter').install(parsers)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then return end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            -- enable the parser if it is installed
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
-- }}}
-- {{{ neovim/nvim-lspconfig
-- from "nvim-lua/kickstart.nvim"
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 'saghen/blink.cmp' },
        {
          "mason-org/mason.nvim",
          build = ":MasonUpdate",
          config = function()
          require("mason").setup()
          end,
        },
        -- { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        { "mason-org/mason-lspconfig.nvim" },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),

          callback = function(event)
              local map = function(mode, keys, func, desc)
                  vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
              end

              map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
              -- map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
              map('n', 'gD', vim.lsp.buf.type_definition, '[G]oto [D]eclaration')
              map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
              map('n', 'gh', vim.lsp.buf.signature_help, '[G]oto signature [H]elp')
              map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
              map('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
              map('n', '<leader>lr', vim.lsp.buf.rename, '[R]ename')
              map('n', '<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')
              map('n', '<leader>lf', vim.lsp.buf.format, '[F]ormat')
              -- Diagnostic keymaps
              map('n', '[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
              map('n', ']d', vim.diagnostic.goto_next, 'Next [D]iagnostic ')
              map('n', '<leader>lq', vim.diagnostic.setqflist, 'Diagnostic [Q]uickfix')
          end,
      })

      vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
          config = config or {}
          config.border = "single"
          return vim.lsp.handlers.hover(_, result, ctx, config)
      end

      vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
          config = config or {}
          config.border = "single"
          return vim.lsp.handlers.signature_help(_, result, ctx, config)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())  -- nvim-cmp
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())  -- blink.cmp

      -- { "pylsp", "vimls", "lua_ls", "matlab_ls" }
      local servers = {
          -- clangd = {},
          -- gopls = {},
          -- pylsp: 补全第三方库
          -- 修改 C:\Users\ThinkPad\AppData\Local\nvim-data\mason\packages\python-lsp-server\venv\pyvenv.cfg
          -- 设置 'include-system-site-packages = true'
          -- pylsp = {
          --     settings = {
          --         pylsp = {
          --             plugins = {
          --                 jedi_completion = {
          --                     enabled = true,
          --                     fuzzy = true,
          --                     include_params = true, -- this line enables snippets
          --                     cache_for = { 'numpy','matplotlib' },
          --                 },
          --                 pycodestyle = {
          --                     maxLineLength = 150,
          --                 },
          --             },
          --         },
          --     },
          -- },
          pyright = {},
          -- pylsp = {},
          tinymist = {
              single_file_support = true,
              settings = {
                  formatterMode = 'typstyle',
                  exportPdf = 'onSave',  --pdf保存预览
                  -- exportPdf = 'onType',  --pdf实时预览
              },
          },
          lua_ls = {
              -- cmd = {...},
              -- filetypes { ...},
              -- capabilities = {},
              settings = {
                  Lua = {
                      runtime = { version = 'LuaJIT' },
                      workspace = {
                          checkThirdParty = false,
                          -- Tells lua_ls where to find all the Lua files that you have loaded
                          -- for your neovim configuration.
                          -- library = {
                          -- '${3rd}/luv/library',
                          -- unpack(vim.api.nvim_get_runtime_file('', true)),
                          -- },
                          -- If lua_ls is really slow on your computer, you can try this instead:
                          library = { vim.env.VIMRUNTIME },
                      },
                      completion = {
                          callSnippet = 'Replace',
                      },
                      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                      diagnostics = { disable = { 'missing-fields' } },
                  },
              },
          },
      }

      require('mason').setup()

      -- LSP
      local ensure_installed = vim.tbl_keys(servers or {})
      require("mason-lspconfig").setup({
          ensure_installed = ensure_installed
      })

      require('mason-lspconfig').setup {
          handlers = {
              function(server_name)
                  local server = servers[server_name] or {}
                  -- This handles overriding only values explicitly passed
                  -- by the server configuration above. Useful when disabling
                  -- certain features of an LSP (for example, turning off formatting for tsserver)
                  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                  require('lspconfig')[server_name].setup(server)
              end,
          },
      }

      -- diagnostic config
      local signs = { Error = '', Warn  = '', Hint  = '', Info  = '' }
      for type, icon in pairs(signs) do
          local hl = 'DiagnosticSign' .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
          virtual_text = {
              prefix = '●',  -- , , , ●
          },
          underline = false,
          signs = true,
          update_in_insert = false, -- default is false
          severity_sort = true, -- default is false
          float = {
              focusable = true,
              style = 'minimal',
              border = 'rounded',
              show_header = true,
              source = 'always',
              -- source = 'if_many',
              header = "",
              prefix = "",
          },
      })

      -- diagnostics开关设置
      local diagnostics_active = false
      vim.diagnostic.enable(diagnostics_active)  -- 默认关闭diagnostics
      local function toggle_diagnostics()
          diagnostics_active = not diagnostics_active
          vim.diagnostic.enable(diagnostics_active)
          require('lualine').refresh()
          print(diagnostics_active and "Diagnostics ON" or "Diagnostics OFF")
      end
      neomap('n', '<F8>', toggle_diagnostics, { desc = 'Toggle diagnostics' })

      neomap('n', '<F7>', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
      neomap('n', '<leader>ld', vim.diagnostic.setloclist, { desc = 'LSP: [D]iagnostic quickfix list' })
    end,
  },
-- }}}
-- {{{ Saghen/blink.cmp
  {
    'saghen/blink.cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        -- { "saghen/blink.compat", opts = { impersontate_nvim_cmp = true, } },
        { "saghen/blink.compat", opts = {} },
        { "L3MON4D3/LuaSnip",
            config = function()
                if vim.fn.has("unix") == 1 then
                require("luasnip/loaders/from_vscode").lazy_load({ paths = {"~/.config/nvim/support/friendly-snippets"}})
                else
                require("luasnip/loaders/from_vscode").lazy_load({ paths = {"D:/Dotfiles/nvim/nvim/support/friendly-snippets"}})
                end
            end,
            init = function()
                if vim.fn.has("unix") == 1 then
                    neomap("n", "<leader>rsm", ":<C-U>e ~/.config/nvim/support/friendly-snippets/add_snippets/Maxl_matlab.json<CR>", { desc = 'Snippets: [M]atlab' })
                    neomap("n", "<leader>rsp", ":<C-U>e ~/.config/nvim/support/friendly-snippets/add_snippets/Maxl_python.json<CR>", { desc = 'Snippets: [P]ython' })
                    neomap("n", "<leader>rso", ":<C-U>e ~/.config/nvim/support/friendly-snippets/add_snippets/Maxl_org.json<CR>", { desc = 'Snippets: [O]rg' })
                    neomap("n", "<leader>rst", function()
                        Snacks.picker.files({
                            cwd = "~/.config/nvim/support/friendly-snippets/add_snippets/Typst",
                        })
                    end, { desc = "Snippets: [T]ypst" })
                    neomap("n", "<leader>rsg", ":<C-U>e ~/.config/nvim/support/friendly-snippets/snippets/global.json<CR>", { desc = '[G]lobel Snippets' })
                else
                    neomap("n", "<leader>rsm", ":<C-U>e D:/Dotfiles/nvim/nvim/support/friendly-snippets/add_snippets/Maxl_matlab.json<CR>", { desc = 'Snippets: [M]atlab' })
                    neomap("n", "<leader>rsp", ":<C-U>e D:/Dotfiles/nvim/nvim/support/friendly-snippets/add_snippets/Maxl_python.json<CR>", { desc = 'Snippets: [P]ython' })
                    neomap("n", "<leader>rso", ":<C-U>e D:/Dotfiles/nvim/nvim/support/friendly-snippets/add_snippets/Maxl_org.json<CR>", { desc = 'Snippets: [O]rg' })
                    neomap("n", "<leader>rst", function()
                        Snacks.picker.files({
                            cwd = "D:/Dotfiles/nvim/nvim/support/friendly-snippets/add_snippets/Typst",
                        })
                    end, { desc = "Snippets: [T]ypst" })
                    neomap("n", "<leader>rsg", ":<C-U>e D:/Dotfiles/nvim/nvim/support/friendly-snippets/snippets/global.json<CR>", { desc = '[G]lobel Snippets' })
                    neomap("n", "<leader>rsT", ":<C-U>e C:/Users/ThinkPad/AppData/Roaming/Code/User/snippets/typst.json<CR>", { desc = 'VSC Snippets: [T]ypst' })
                    neomap("n", "<leader>rsL", ":<C-U>e C:/Users/ThinkPad/AppData/Roaming/Code/User/snippets/latex.json<CR>", { desc = 'VSC Snippets: [L]aTeX' })
                end
            end,
        },
        { "mstanciu552/cmp-matlab" },
        {
          "uga-rosa/cmp-dictionary",
          branch = "main",
          commit = "93f3e2c",
          config = function()
              local dic = {}
              if vim.fn.has("unix") == 1 then
                  dic["*"] = "~/.config/nvim/support/Directionary-8813.dic"
                  -- ["*"] = { "~/.config/nvim/support/Directionary-69903.dic" },
              else
                  dic["*"] = "D:/Dotfiles/nvim/nvim/support/Directionary-8813.dic"
                  -- ["*"] = { "D:/Dotfiles/nvim/nvim/support/Directionary-69903.dic" },
              end
              require("cmp_dictionary").setup({
                  dic = dic,
                  exact = 2,
                  first_case_insensitive = true,
                  document = false,
                  document_command = "wn %s -over",
                  async = true,     --If you are using a very large dictionary and the body operation is blocked, try 'true'
                  max_items = -1,   --This is the maximum number of candidates that this source will return to the nvim-cmp body. -1 means no limit.
                  capacity = 5,
                  debug = false,
              })
              vim.cmd("CmpDictionaryUpdate")
          end,
        },
    },
    version = '1.*',
    branch = "main",
    -- commit = "cb5e346",  -- 对应v1.1.1版本; v1.2.0版本报错
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            -- preset = 'default',
            ['<Tab>'] = { 'accept', 'fallback' },
            ['<Cr>'] = { 'accept', 'fallback' },
            -- ["<Esc>"] = { "hide", "fallback" },

            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },

            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },

            ['<C-f>'] = { 'select_prev', 'fallback' },
            ['<C-b>'] = { 'select_next', 'fallback' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-p>'] = { 'show', 'show_documentation', 'hide_documentation' },

            -- disable a keymap from the preset
            -- ['<C-e>'] = {},
        },

        cmdline = {
            enabled = true,
            keymap = {
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<Tab>'] = { 'accept', 'fallback' },
            },
            sources = function()
                local type = vim.fn.getcmdtype()

                if type == "/" or type == "?" then return { "buffer" } end
                if type == ":" or type == "@" then
                    return { "cmdline" }
                end
                return {}
            end,
            completion = { menu = { auto_show = true } },
        },

        enabled = function() return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false end,

        snippets = { preset = 'luasnip' },
        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            menu = {
                -- border = 'single',
                -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
                min_width = 15,
                max_height = 15,
                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                    cursorline_priority = 0,
                },
            },
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 50,  --200文档跳出时间
              update_delay_ms = 50,
              treesitter_highlighting = true,
              window = {
                min_width = 10,
                max_width = 60,
                max_height = 20,
                -- border = 'single', -- padded
                border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
                winblend = 0,
                winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
                scrollbar = true,
                direction_priority = {
                  -- menu_north = { 'e', 'w', 'n', 's' },
                  -- menu_south = { 'e', 'w', 's', 'n' },
                  menu_north = { 'e' },
                  menu_south = { 'e' },
                },
              },
            },
            ghost_text = {
              enabled = false,
            },
        },
        signature = {  --🐼,🧐🤔📌
              enabled = true,
              window = { border = 'single' },
        },
        sources = {
            -- default = { 'lsp', 'path', 'snippets', 'buffer', 'cmp_matlab', 'dictionary' },
            default = { 'lsp', 'path', 'snippets', 'buffer', 'cmp_matlab' },

            per_filetype = {
                -- lua = { 'lsp', 'path', 'snippets' },
                -- python = { 'lsp', 'path', 'snippets' },
                -- typst = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            providers = {
                lsp = {
                    name = 'LSP',
                    module = 'blink.cmp.sources.lsp',

                    enabled = true, -- Whether or not to enable the provider
                    transform_items = nil, -- Function to transform the items before they're returned
                    should_show_items = true, -- Whether or not to show the items
                    max_items = nil, -- Maximum number of items to display in the menu
                    min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
                    fallbacks = {}, -- If any of these providers return 0 items, it will fallback to this provider
                    score_offset = 0, -- Boost/penalize the score of the items
                    override = nil, -- Override the source's functions
                },
                path = {
                    name = 'Path',
                    module = 'blink.cmp.sources.path',
                    score_offset = 3,
                    opts = {
                        trailing_slash = false,
                        label_trailing_slash = true,
                        get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
                        show_hidden_files_by_default = false,
                    }
                },
                snippets = {
                    name = 'Snippets',
                    module = 'blink.cmp.sources.snippets',
                    score_offset = -3,
                    opts = {
                        use_show_condition = true,
                        show_autosnippets = true,
                    },
                },

                buffer = {
                    name = 'Buffer',
                    module = 'blink.cmp.sources.buffer',
                    opts = {
                        -- default to all visible buffers
                        get_bufnrs = function()
                            return vim
                                .iter(vim.api.nvim_list_wins())
                                :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                                :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                                :totable()
                        end,
                    },
                },
                cmp_matlab = {
                    name = 'cmp_matlab',
                    module = 'blink.compat.source',
                    score_offset = -3,
                    opts = {},
                    transform_items = function(ctx, items)
                        local kind = require("blink.cmp.types").CompletionItemKind.Function
                        for i, _ in ipairs(items) do
                            items[i].kind = kind
                        end
                        return items
                    end,
                },
                dictionary = {
                    name = 'dictionary',
                    module = 'blink.compat.source',
                    score_offset = -3,
                    opts = {},
                    transform_items = function(ctx, items)
                        local kind = require("blink.cmp.types").CompletionItemKind.Text
                        for i, _ in ipairs(items) do
                            items[i].kind = kind
                        end
                        return items
                    end,
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
            kind_icons = {
                Text = '  ',  --󰉿
                Method = '  ',  --󰊕
                Function = '  ',  --󰊕 ƒ
                Constructor = '  ',  --󰒓

                Field = '  ',  --󰜢
                Variable = '  ',  --󰜢
                Property = ' ﰠ ',  --󰖷

                Class = ' ﴯ ',  --󱡠
                Interface = ' ﰮ ',  --󱡠
                Struct = ' פּ ',  --󱡠
                Module = '  ',  --󰅩

                Unit = '  ',  --󰪚
                Value = '  ',  --󰦨
                Enum = '  ',  --󰦨
                EnumMember = '  ',  --󰦨

                Keyword = '  ',  --󰻾
                Constant = '  ',  --󰏿

                Snippet = '  ',  --󱄽 
                Color = '  ',  --󰏘
                File = '  ',  --󰈔
                Reference = '  ',  --󰬲
                Folder = '  ',  --󰉋
                Event = '  ',  --󱐋
                Operator = '  ',  --󰪚
                TypeParameter = '  ',  --󰬛
            },
        },
    },
    opts_extend = { "sources.default" }
  },
-- }}}

-- {{{ 396458015/vim-speeddating-modified
  { "396458015/vim-speeddating-modified", ft = { "markdown", "org" } }, --modified
-- }}}
-- {{{ 396458015/imeflow.nvim
 {
  "396458015/imeflow.nvim",
  lazy = true,
  event = "InsertEnter",
  opts = {
      path = vim.fn.has("unix") == 1 and "/mnt/c/Users/ThinkPad/AppData/Local/nvim-data/Maxl/im-select.exe" or nil,
      enabled = false,   -- Start enabled (default: true)
      mapping = "<F2>", -- Optional toggle mapping

      -- Optional per-event enable/disable
      VimEnter    = false,
      InsertEnter = true,
      InsertLeave = true,
      VimLeave    = false,
  },
 },
-- }}}
-- {{{ 396458015/foldmarker.nvim
  {
    "396458015/foldmarker.nvim",
    keys = {
        { "<leader>mm", mode = "x", desc = "Add fold marker" },
        { "<leader>mi", mode = "n", desc = "Delete fold marker" },
    },
    config = function()
        require("foldmarker").setup({
            enable_title = true,
            title_prompt = "Fold title: ",
            add_mapping = "<leader>mm",
            delete_mapping = "<leader>mi",
        })
    end,
  },
-- }}}

-- {{{ Eandrju/cellular-automaton.nvim
  {
    "Eandrju/cellular-automaton.nvim",
    keys = { { "<localleader>,", "<cmd>CellularAutomaton make_it_rain<CR>", mode = "n", desc = "make it rain" } }
  },
-- }}}
-- {{{ HaoHao-Ting/vim-matlab-formatter
  { "HaoHao-Ting/vim-matlab-formatter",
    ft = "matlab",
    cmd = "MatlabFormatter",
    config = function()
    if vim.bo.filetype == 'matlab' then
      neomap('n', '<leader>lf', ':MatlabFormatter<CR>', { desc = "Matlab [F]ormat" })
    end
    end,
  },
-- }}}
-- {{{ lewis6991/gitsigns.nvim
  {
	"lewis6991/gitsigns.nvim",
    -- branch = "main",
    -- commit = "6668f37",  -- 对应v1.0.1版本; v1.0.2版本软件不生效
    event = "BufRead",
    keys = {
        { "<leader>gp", mode = { "n" }, "<cmd>Gitsigns preview_hunk<cr>", desc = "[P]review Hunk" },
        { "<leader>gd", mode = { "n" }, "<cmd>Gitsigns diffthis<cr>", desc = "[D]iff" },

        { "<leader>gl", mode = { "n" }, "<cmd>Gitsigns blame_line<cr>", desc = "B[l]ame" },

        { "<leader>gj", mode = { "n" }, "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
        { "<leader>gk", mode = { "n" }, "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },

        { "<leader>gr", mode = { "n" }, "<cmd>Gitsigns reset_hunk<cr>", desc = "[r]eset Hunk" },
        { "<leader>gR", mode = { "n" }, "<cmd>Gitsigns reset_buffer<cr>", desc = "[R]eset Buffer" },

        { "<leader>gt", mode = { "n" }, "<cmd>Gitsigns toggle_word_diff<cr>", desc = "[T]oggle word_diff" },

        -- { "<leader>gs", mode = { "n", "v" }, "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
        -- { "<leader>gu", mode = { "n", "v" }, "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
    },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			signs = {
				add          = { text = ' ' },-- 
				change       = { text = ' ' },-- 
				delete       = { text = ' ' },-- 
				topdelete    = { text = ' ' },-- 
				changedelete = { text = ' ' },-- ▐
				untracked    = { text = ' ' },-- ★  
			},
            signs_staged = {
              add          = { text = ' ' },
              change       = { text = ' ' },
              delete       = { text = ' ' },
              topdelete    = { text = ' ' },
              changedelete = { text = ' ' },
              untracked    = { text = ' ' },
            },
            signs_staged_enable = true,
			signcolumn     = true,  -- Toggle with `:Gitsigns toggle_signs`
			linehl         = false, -- Toggle with `:Gitsigns toggle_linehl`
			numhl          = false, -- Toggle with `:Gitsigns toggle_nunhl`
			word_diff      = true,  -- Toggle with `:Gitsigns toggle_word_diff`
			sign_priority  = 9,
			watch_gitdir   = {
				interval     = 1000,
			},
			attach_to_untracked = false,
		})
    -- signs color
        if vim.o.background == 'dark' then
            vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#a6d189", bg = "None" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e78284", bg = "None" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#26deff", bg = "None" })
        elseif vim.o.background == 'light' then
            vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#40a02b", bg = "None" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#d20f39", bg = "None" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#04a5e5", bg = "None" })
        end
    -- word_diff color
    vim.api.nvim_set_hl(0, "GitSignsAddInline",    { fg = "#00cc00", bg = "#005500" })
    vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { fg = "#cc0000", bg = "#550000" })
    vim.api.nvim_set_hl(0, "GitSignsChangeInline", { fg = "#00cc00", bg = "#005500" })
	end,
  },
-- }}}
-- {{{ nguyenvukhang/nvim-toggler
  {
    "nguyenvukhang/nvim-toggler",
    keys = { { "<leader>i", function() require('nvim-toggler').toggle() end, mode = { "n", "v" }, desc = "Toggle word" } },
	config = function()
    require('nvim-toggler').setup({
      inverses = {
        ['True'] = 'False',
        ['true'] = 'false',
        ['yes'] = 'no',
        ['on'] = 'off',
        ['left'] = 'right',
        ['up'] = 'down',
        -- ['!='] = '==',
      },
      remove_default_keybinds = true, -- removes the default <leader>i keymap
      remove_default_inverses = true, -- removes the default set of inverses
    })
	end,
  },
-- }}}
-- {{{ folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    opts = {
        preset = "helix",  --classic, modern, helix
        plugins = {
            spelling = { enabled = false },
        },
        win = {
            title_pos = "center",
        },
        icons = {
            breadcrumb = "", -- »
            separator = "│",  -- ➜   │
            group = "", -- + 󰙅    
            -- set plugin icon (color: azure, blue, cyan, green, grey, orange, purple, red, yellow)
            rules = {
                -- { plugin = "neo-tree.nvim",           icon = "󰙅", color = "orange" },
                { plugin = "oil.nvim",                icon = "󰙅", color = "orange" },
                { plugin = "vim-interestingwords",    icon = "", color = "red" },
                { plugin = "undotree",                icon = "", color = "red" },
                { plugin = "cellular-automaton.nvim", icon = "", color = "red" },
            },
        },
        spec = {
            { "<leader>c",      desc = "[C]omment",            icon = { icon = "", color = "red" } },
            { "<leader>d",      desc = "[D]iff",               icon = { icon = "", color = "orange" } },
            { "<leader>f",      desc = "Leader[F]",            icon = { icon = "", color = "cyan" } },
            { "<leader>fr",     desc = "[R]ecently Files",     icon = { icon = "", color = "green" } },
            { "<leader>g",      desc = "[G]it",                icon = { icon = "", color = "orange" } },
            { "<leader>s",      desc = "[S]pell",              icon = { icon = "", color = "red" } },
            { "<leader>o",      desc = "[O]rg",                icon = { icon = "", color = "green" } },
            { "<leader>w",      desc = "Python Send",          icon = { icon = "", color = "yellow" } },
            { "<leader>l",      desc = "[L]SP",                icon = { icon = "ﲳ", color = "orange" } },

            { "<leader>r",      desc = "VIM[R]C & [S]nippets", icon = { icon = "", color = "green" } },
            { "<leader>rs",     desc = "[S]nippets",           icon = { icon = "", color = "yellow" } },

            { "<leader>t",      desc = "[T]erminal",           icon = { icon = "", color = "grey" } },
            { "<leader>tn",     desc = "Term [N]ext",          icon = { icon = "", color = "grey" } },
            { "<leader>tp",     desc = "I[P]yhon",             icon = { icon = "", color = "yellow" } },
            { "<leader>ta",     desc = "Term([A]dmin)",        icon = { icon = "", color = "yellow" } },

            { "<localleader>l", desc = "[L]atex",              icon = { icon = "ﭨ", color = "green" } },
            { "<localleader>w", desc = "Count Chinese [W]ords",   icon = { icon = "", color = "blue" }, mode = { "n", "v" } }, -- 

      -- set function icon
            { "<leader> ",      desc = "Calculator",   icon = { icon = "", color = "cyan" } }, -- bug
            { "<leader>\\",     desc = "Smart split",  icon = { icon = "", color = "yellow" } },
            { "<leader>z",      desc = "Replace Word", icon = { icon = "", color = "red" } },
            { "<leader>b",      desc = "Columns Num",  icon = { icon = "", color = "cyan" } },
            { "<leader>q",      desc = "[Q]uit/Kill Buffer",  icon = { icon = "", color = "purple" } },
            { "<leader>y",      desc = "[Y]ank Path (file)",  icon = { icon = "", color = "cyan" } },
            { "<leader><Tab>",  desc = "[Tab]new",  icon = { icon = "󰓩", color = "yellow" } },

            { "<localleader>T",  desc = "[T]ag",  icon = { icon = "ﰠ", color = "purple" } },
            { "<localleader>F",  desc = "[F]unction",  icon = { icon = "", color = "cyan" } },
            { "<localleader>r",  desc = "[R]ecently Files",  icon = { icon = "", color = "green" } },
        },
    },
  },
-- }}}
})
-- }}}

-- {{{ colorscheme
local term_sign = vim.loop.os_getenv("MYSIGN")

if vim.fn.has('gui_running') == 1 then
    local colorscheme_list = {
        'catppuccin-frappe',
        -- 'catppuccin-latte',
    }
    local randomIndex_CS = math.random(1,#colorscheme_list)
    vim.cmd('colorscheme ' .. colorscheme_list[randomIndex_CS])
else
    if term_sign == "alacritty_sign" then          -- alacritty
        vim.cmd('colorscheme catppuccin-frappe')
    elseif term_sign == "wezterm_sign" then        -- wezterm
        vim.cmd('colorscheme catppuccin-frappe')
    elseif term_sign == "wt_sign" then             -- windows-terminal
        vim.cmd('colorscheme catppuccin-frappe')
        -- vim.cmd('colorscheme catppuccin-latte')
    else
        vim.cmd('colorscheme catppuccin-frappe')
    end
end
-- }}}

-- {{{ highlihgt (origin neovim & plugins)
-- folded color
vim.api.nvim_set_hl(0, "Folded", { fg = "#c9a0a9", bg = "#403940", bold = true, italic = true })

-- cmp color
local fgdark = "#2E3440"
vim.api.nvim_set_hl(0, "Pmenu",    { fg = "#5b678f", bg = nil}) -- cmp documentation font color
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",      { fg = "#82AAFF", bg = nil, bold = true })  -- #9CDCFE
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#b5585f", bg = nil, bold = true })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = nil, bg = "#3c4452"}) -- cmp 选中行背景颜色
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" }) -- #9CDCFE
    vim.api.nvim_set_hl(0, "CmpItemKindFile",     { fg = fgdark, bg = "#93a9ed" })  -- #9CDCFE
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",      { fg = "#2E3440", bg = nil, bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#d73a4a", bg = nil, bold = true })
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = nil, bg = "#ccd0da"}) -- cmp 选中行背景颜色
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#acb0be" }) -- #9CDCFE
    vim.api.nvim_set_hl(0, "CmpItemKindFile",     { fg = fgdark, bg = "#acb0be" })  -- #9CDCFE
end

vim.api.nvim_set_hl(0, "CmpItemAbbr",           { fg = "#949cbb", bg = nil })  -- #abb2bf
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = nil, strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemMenu",           { fg = "#C792EA", bg = nil, italic = true })  -- #ef9f76

vim.api.nvim_set_hl(0, "CmpItemKindField",    { fg = fgdark, bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent",    { fg = fgdark, bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText",    { fg = fgdark, bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum",    { fg = fgdark, bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant",    { fg = fgdark, bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference",   { fg = fgdark, bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct",   { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass",    { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule",   { fg = fgdark, bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit",    { fg = fgdark, bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder",  { fg = fgdark, bg = "#8ec07c" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod",     { fg = fgdark, bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue",      { fg = fgdark, bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface",     { fg = fgdark, bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor",         { fg = fgdark, bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })

-- Diagnostics Highlights
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff3939" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#ffa500" })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = "#1d6a70" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = "#FFCC66" })

vim.api.nvim_set_hl(0, "DiagnosticsDefaultError",    { bg = nil })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff3939", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ffa500", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#1d6a70", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#FFCC66", bg = nil, italic = true })

vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "#ff3939", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn",  { fg = "#ffa500", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint",  { fg = "#1d6a70", bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo",  { fg = "#FFCC66", bg = nil, italic = true })

vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff3939" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  { fg = "#ffa500" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint",  { fg = "#1d6a70" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  { fg = "#FFCC66" })

-- snacks.picker
vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#d3366f", bold = true })

-- dark & light colorscheme
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    -- search color
    vim.api.nvim_set_hl(0, "Search", { fg = "#ccd0da", bg = "#228b22" })
    -- cuc cul color
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#3C4452" })
    vim.api.nvim_set_hl(0, "Cursorcolumn", { bg = "#3C4452" })
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    -- search color
    vim.api.nvim_set_hl(0, "Search", { fg = "#e1e2e7", bg = "#40a02b" })
    -- cuc cul color
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#c6cbd9" })
    vim.api.nvim_set_hl(0, "Cursorcolumn", { bg = "#c6cbd9" })
end
-- diff color (original neovim)
vim.api.nvim_set_hl(0, "DiffAdd",    { fg = "#00cc00", bg = "#005500" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#cc0000", bg = "#550000" })
vim.api.nvim_set_hl(0, "DiffChange", { fg = "#000000", bg = "#7A7A7A" })
vim.api.nvim_set_hl(0, "DiffText",   { fg = "#00cc00", bg = "#005500" })
-- lsp_signature.nvim color
vim.api.nvim_set_hl(0, "lsp_signature_highlight", { fg = "#000000", bg = "#f68e26" })
-- mg979/vim-visual-multi theme
if vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'dark' then
    vim.g.VM_theme = 'iceblue'
elseif vim.fn.exists('&bg') and vim.fn.eval('&bg') == 'light' then
    vim.g.VM_theme = 'lightblue2'
end
-- }}}

-- {{{ GUI&TERM
if vim.g.neovide then-- neovide
    vim.g.neovide_cursor_vfx_mode = "pixiedust"  -- "railgun", torpedo", "pixiedust", "ripple"
    vim.g.neovide_cursor_vfx_particle_density = 3.0
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_refresh_rate = 60

    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_scroll_animation_length = 0

    vim.g.neovide_opacity = 1.0  -- 0.9
    vim.g.neovide_fullscreen = false
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_remember_window_position = true
    vim.g.neovide_confirm_quit = true              -- 修改文件后退出提示
    vim.g.neovide_hide_mouse_when_typing = true    -- 输入时隐藏鼠标
    -- vim.g.neovide_profiler = true               -- 左上角显示帧数
    -- Adjust transparency
    neomap('n', '<C-_>', ':let g:neovide_opacity -= 0.05<CR>:let g:neovide_opacity<CR>', {})
    neomap('n', '<C-+>', ':let g:neovide_opacity += 0.05<CR>:let g:neovide_opacity<CR>', {})
    neomap('i', '<C-_>', '<C-o>:let g:neovide_opacity -= 0.05<CR><C-o>:let g:neovide_opacity<CR>', {})
    neomap('i', '<C-+>', '<C-o>:let g:neovide_opacity += 0.05<CR><C-o>:let g:neovide_opacity<CR>', {})
    -- Toggle fullscreen
    neomap("n", "<m-CR>", function()
        vim.g.neovide_fullscreen = vim.g.neovide_fullscreen == 1 and 0 or 1
    end, { desc = "Toggle fullscreen" })
elseif vim.g.nvy then-- nvy
else-- terminal
    -- vim.api.nvim_command("hi Normal guibg=NONE")
    -- vim.api.nvim_command("hi NonText guibg=NONE")
    -- vim.api.nvim_command("hi SignColumn guibg=NONE")
end
-- }}}







