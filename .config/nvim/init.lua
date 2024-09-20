-- NEOVIM without plugin

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
-- vimrc
neomap('n', '<leader>rc', ':edit $MYVIMRC<CR>', { desc = 'Edit VIMRC' })
neomap('n', '<leader>rr', ':source $MYVIMRC<CR>', { desc = '[R]eload VIMRC' })
-- 插入时间
vim.cmd([[iab xtime <c-r>=strftime("20%y-%m-%d %a %H:%M")<CR>]])
vim.cmd([[iab xdate <c-r>=strftime("20%y-%m-%d (%a)")<CR>]])
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

-- vim.cmd('colorscheme evening')
-- vim.cmd('colorscheme desert')
-- vim.cmd('colorscheme morning')
-- vim.cmd('colorscheme catppuccin_latte')
vim.cmd('colorscheme catppuccin_frappe')
-- vim.cmd('colorscheme gruvbox')

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
local vim_opts = {
    autochdir = true,  -- 设定文件浏览器目录为当前目录
    autoindent = true,  -- 自动对齐
    backspace = "indent,eol,start",
    backup = false,
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    clipboard = "unnamedplus",  -- Sync with system clipboard
    cmdheight = 1,
    confirm = true,
    cursorline = false,
    encoding = "utf-8",
    errorbells = false,
    expandtab = true,  -- 在输入tab后,vim用个空格来填充这个tab
    fileencoding = "utf-8",
    fileencodings = "utf-8,gbk,gb18030,big5,ucs-bom,euc-jp,latin1",
    foldenable = true,
    foldlevel = 33,
    foldmethod = 'marker',  -- 折叠类型---对文中标志折叠
    formatoptions = "1jcroql",
    hidden = true,  -- 允许在有未保存的修改时切换缓冲区
    showmode = false,
    hlsearch = true,
    ignorecase = true,  -- 忽略大小写
    incsearch = true,  -- 开启实时搜索功能
    laststatus = 2,  -- 3:global Statusline, default is 2
    linebreak = true,
    list = true,
    listchars = { tab = '» ', trail = '·', nbsp = '␣' },
    magic = true,
    mouse = "a",
    number = true,
    relativenumber = true,
    ruler = false,  -- 右下角显示光标位置的状态行
    scrolloff = 5,  -- 设置目标行与顶部底部的距离(5行)
    sessionoptions = "buffers,curdir,help,tabpages,winsize",
    shiftround = true,
    shiftwidth = 4,  -- Size of an indent
    showcmd = true,
    showmatch = true,  -- 显示括号配对情况
    sidescroll = 5,
    sidescrolloff = 15,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,  -- Insert indents automatically
    softtabstop = 4,  -- 退格键的长度
    spelllang = "en_us",
    splitbelow = true,
    splitright = true,
    startofline = false,
    swapfile = false,
    tabstop = 4,  -- 设置tab键的宽度
    termguicolors = true,
    ttimeoutlen = 0,
    undofile = true,
    timeout = true,
    updatetime = 250,
    timeoutlen = 300,
    visualbell = true,
    whichwrap = "h,l,<,>,[,],~",  -- 允许backspace和光标键跨越行边界
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    wildignorecase = true,
    wildmenu = true,
    wildmode = "longest:full,full",  -- Command-line completion mode
    wrap = true,
    writebackup = false,
    inccommand="nosplit"
    -- shell = "C:/PROGRA~1/PowerShell/7/pwsh.exe" -- pwsh7,启动速度200+ms
}
for k, v in pairs(vim_opts) do
    vim.opt[k] = v
end

vim.cmd[[
filetype indent on
filetype plugin on
set foldcolumn=2
]]
if vim.fn.has("nvim-0.9.5") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end
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
-- Return to last edit position when opening files (You want this!)
vim.cmd([[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])
-- }}}

-- {{{ autocmds
vim.cmd[[

" 解决matlab中文乱码的问题
augroup matlab_filetype
    au!
    au FileType matlab set fileencoding=cp936
augroup END

" 文本超过一定长度时自动换行
augroup tex_md_width
    au!
    au FileType tex set textwidth=72
    au FileType markdown set textwidth=80
augroup END

" 高亮加下划线显示每行第80个字符
" Fortran语言,高亮加下划线显示每行第72个字符(遵循Fortran77固定格式)
augroup line_font
    au!
    au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.hs,*.vim,*.md 2match Underlined /.\%81v/
    au BufRead,BufNewFile *.for 2match Underlined /.\%73v/
augroup END

" 当剩余的窗口都不是文件编辑窗口时,自动退出vim
augroup Buffer_quit
    au!
    au BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
augroup END
]]

-- 设置 HighlightedyankRegion 高亮组
vim.api.nvim_set_hl(0, "HighlightedyankRegion", { bg = "#c34043" })
-- 创建一个自动命令组，避免重复创建
local yank_group = vim.api.nvim_create_augroup('highlight_yank', { clear = true })
-- 添加 TextYankPost 事件的自动命令
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'HighlightedyankRegion',
            timeout = 120,
        })
    end,
})

-- nvim_create_augroups(autocmds)
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command "autocmd!"
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command "augroup END"
    end
end

nvim_create_augroups({
    custom_filetypes = {
        { "BufNewFile,BufRead", "*.rpy", "set syntax=python" },
        { "BufNewFile,BufRead", "*.py", "set fileformat=unix" },

        { "BufRead", "*.md", "set conceallevel=2" },
    },
    save_shada = {
        { "VimLeave", "*", "wshada!" },
    },  -- save marks
})
-- }}}

-- {{{ statusline
-- 定义获取当前模式的函数
_G.get_mode = function()
  local mode_map = {
    n = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'V-LINE',
    [''] = 'V-BLOCK',
    c = 'COMMAND',
    t = 'TERMINAL',
    -- 你可以根据需要添加更多模式
  }
  return mode_map[vim.fn.mode()] or vim.fn.mode()
end

-- 配置状态栏
local statusline = {
  '%{v:lua.get_mode()} ',    -- 显示当前模式
  ' %F',                     -- 文件的完整路径和文件名
  '%r',                      -- 只读标志
  '%m',                      -- 修改标志
  '%=',                      -- 分隔符，左边内容靠左，右边内容靠右
  '%{&filetype}',            -- 文件类型
  ' %2p%%',                  -- 文件百分比
  ' %-2c:%3l '               -- 列号和行号
}
vim.o.statusline = table.concat(statusline, '')
-- }}}

-- {{{ highlihgt
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#9fbd73", fg = "#000000" })
vim.api.nvim_set_hl(0, "Search", { fg = "#e1e2e7", bg = "#40a02b" })
vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#e78284", bold = true })
-- }}}

-- {{{ Auto Completion
vim.cmd[[
" Auto Completion - Enable Omni complete features
set omnifunc=syntaxcomplete#Complete

" Enable Spelling Suggestions for Auto-Completion:
set complete+=k
set completeopt=menu,menuone,noinsert

" Minimalist-Tab Complete
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfun


" Minimalist-Autocomplete 
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 3] =~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'

        call feedkeys("\<C-N>", 'n')
    end
endfun
]]
-- }}}

-- {{{ Parentheses complete
vim.api.nvim_set_keymap('i', '(', '()<Esc>i', key_opts_ns)
vim.api.nvim_set_keymap('i', '{', '{}<Esc>i', key_opts_ns)
vim.api.nvim_set_keymap('i', '[', '[]<Esc>i', key_opts_ns)
vim.api.nvim_set_keymap('i', '<', '<><Esc>i', key_opts_ns)
vim.api.nvim_set_keymap('i', "'", "''<Esc>i", key_opts_ns)
vim.api.nvim_set_keymap('i', '"', '""<Esc>i', key_opts_ns)
-- }}}

-- {{{ Commenting blocks of code
vim.cmd[[
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
  autocmd FileType lua              let b:comment_leader = '-- '
  autocmd FileType tmux              let b:comment_leader = '# '
augroup END
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>ci :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
]]
-- }}}

-- {{{ HighlightSearch
-- https://vi.stackexchange.com/questions/18546/can-i-use-a-different-color-for-the-selected-match-than-for-other-matches
vim.cmd[[
function! HighlightSearch(timer)
    if (g:firstCall)
        let g:originalStatusLineHLGroup = execute("hi StatusLine")
        let g:firstCall = 0
    endif
    if (exists("g:searching") && g:searching)
        let searchString = getcmdline()
        if searchString == "" 
            let searchString = "."
        endif
        let newBG = search(searchString) != 0 ? "green" : "red"
        if searchString == "."
            set whichwrap+=h
            normal h
            set whichwrap-=h
        endif
        execute("hi StatusLine ctermfg=0" . newBG)
        let g:highlightTimer = timer_start(50, 'HighlightSearch')
        let g:searchString = searchString
    else
        let originalBG = matchstr(g:originalStatusLineHLGroup, 'ctermfg=\zs[^ ]\+')
        execute("hi StatusLine ctermfg=0" . originalBG)
        if exists("g:highlightTimer")
            call timer_stop(g:highlightTimer)
            call HighlightCursorMatch()
        endif
    endif
endfunction
function! HighlightCursorMatch() 
    try
        let l:patt = '\%#'
        if &ic | let l:patt = '\c' . l:patt | endif
        exec 'match IncSearch /' . l:patt . g:searchString . '/'
    endtry
endfunction
nnoremap <silent> n n:call HighlightCursorMatch()<CR>
nnoremap <silent> N N:call HighlightCursorMatch()<CR>
augroup betterSeachHighlighting
    autocmd!
    autocmd CmdlineEnter * if (index(['?', '/'], getcmdtype()) >= 0) | let g:searching = 1 | let g:firstCall = 1 | call timer_start(1, 'HighlightSearch') | endif
    autocmd CmdlineLeave * let g:searching = 0
augroup END
]]
-- }}}



