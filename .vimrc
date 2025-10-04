" Vimscript中使用"进行注释

" 基本设置
" 杂项
set nocompatible " 关闭Vi兼容模式，启用Vim特性
set shortmess+=I " 关闭默认启动信息
set noerrorbells visualbell t_vb= " 关闭系统哔声或屏幕闪烁
set mouse+=a " 支持鼠标移动光标(新手村)

" -----------------------------------------------------------------

" 显示
colorscheme desert " 默认配色
set laststatus=2 " 始终显示状态
syntax on " 设置语法高亮
set number " 设置当前行为绝对行号
set relativenumber " 设置其他行相对行号
set showmatch " 高亮匹配括号
set showcmd " 显示部分命令
set signcolumn=yes " 总显示符号列(暂时没理解)

" -----------------------------------------------------------------

" 插件管理
filetype off " 关闭文件类型检测

call plug#begin('~/.vim/plugged') " 开始

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf命令行
Plug 'junegunn/fzf.vim'                             " fzf.vim插件：模糊搜索
Plug 'preservim/nerdtree'                           " NERDTree：文件树浏览
Plug 'tpope/vim-commentary'                         " vim-commentary：快速注释操作
Plug 'tpope/vim-surround'                           " vim-surround：快速修改成对符号
Plug 'tpope/vim-fugitive'                           " vim-fugitive: Git集成
Plug 'airblade/vim-gitgutter'                       " vim-gitgutter：Git改动可视化
Plug 'easymotion/vim-easymotion'                    " vim-easymotion：快速跳转
Plug 'dense-analysis/ale'                           " ALE：代码实时检查

call plug#end() " 结束

filetype plugin indent on   " 根据文件类型自动缩进

" ALE配置
let g:ale_linters = {'python': ['flake8', 'mypy']} " Python分析器
let g:ale_linters = {'shell': ['shellcheck']}      " Shell分析器
let g:ale_fixers = {'python': ['black','isort']}           " 代码格式化

" 实时检查
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1

" 修复时机
let g:ale_fix_on_save = 1           " 保存时自动运行fixer：直接保存并退出时不修复哈
let g:ale_fix_on_insert_leave = 0   " 离开插入模式不自动修复

" -----------------------------------------------------------------

" 缩进设置
set tabstop=4                  " Tab 显示宽度
set shiftwidth=4               " 缩进空格数 
set expandtab                  " 按Tab插入空格而非\t 
set smartindent                " 自动缩进

" -----------------------------------------------------------------
" -----------------------------------------------------------------

" 其他设置
" 杂项
set wildmenu                   " 命令补全菜单
set lazyredraw                 " 优化宏执行速度
set ttyfast                    " 终端加速

" -----------------------------------------------------------------

" 文件相关
set autoread                " 文件外部修改自动读取
set backup                  " 开启备份
set writebackup             " 写入前备份
set undofile                " 开启持久化撤销
set undodir=~/.vim/undo     " 撤销文件存放路径
set encoding=utf-8          " 符号显示正确
set fileencoding=utf-8      " 跨平台编辑

" -----------------------------------------------------------------

" 按键设置
set backspace=indent,eol,start " 使backspace符合预期

" 解绑Q键
nmap Q <Nop>

" 阻止使用箭头键(养成习惯)
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" 换绑esc
set timeoutlen=300
inoremap jj <Esc>
inoremap jk <Esc>

" 设置leader键
let mapleader=","          " 设置leader键为逗号

" 文件管理
" 保存当前文件:,we | 不保存退出:,qw | 保存并退出:,x | 保存/打开/读取指定文件:,wf/,ef/,rf
nnoremap <leader>we :w<CR> 
nnoremap <leader>wf :<C-u>w<Space>
nnoremap <leader>qw :q!<CR>  
nnoremap <leader>x :wq<CR> 
nnoremap <leader>ef :<C-u>e<Space>
nnoremap <leader>rf :<C-u>r<Space>

" 显示管理
" 窗口移动
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l  

" 停止高亮
nnoremap <leader>nh :noh<CR>

" 分屏
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
nnoremap <leader>vf :<C-u>vsp<Space>
nnoremap <leader>sf :<C-u>sp<Space>

" 缓冲区管理
nnoremap <leader>n :bnext<CR>  
nnoremap <leader>p :bprev<CR>   
nnoremap <leader>l :ls<CR>
