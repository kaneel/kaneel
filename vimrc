call plug#begin()

" ALL BUNDLES
" VIm aesthetic
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Airline
let g:airline_extensions = ['tabline']

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='base16'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" integrate with ale
let g:airline#extensions#ale#enabled = 1

Plug 'bling/vim-bufferline'

" Utility
Plug 'tpope/vim-vinegar'

" languages
Plug 'sheerun/vim-polyglot'
Plug 'ARM9/arm-syntax-vim'
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
" others
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
Plug 'justinmk/vim-sneak'
"--------------------------------
" ALv
Plug 'w0rp/ale'

" ALE config
let g:ale_linter_aliases = {'jsx': ['css', 'javascript'], 'typescriptreact': ['css', 'typescript']} 
let g:ale_fixers = {}
let g:ale_fixers['c'] = ['clangtidy']
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fixers['jsx'] = ['stylelint', 'eslint']
let g:ale_fixers['typescript'] = ['eslint']
let g:ale_fixers['typescriptreact'] = ['eslint']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['rust'] = ['rustfmt']
let g:ale_fixers['reason'] = ['refmt']
let g:ale_linters = {}
let g:ale_linters['c'] = []
let g:ale_linters['javascript'] = ['eslint']
let g:ale_linters['typescript'] = ['eslint']
let g:ale_linters['typescriptreact'] = ['stylelint', 'eslint']
let g:ale_linters['jsx'] = ['stylelint', 'eslint']
let g:ale_linters['rust'] = ['rls']
let g:ale_linters['reason'] = ['reason-language-server']
let g:ale_rust_rls_executable = '/Users/kaneel/.cargo/bin/rls'
" let g:ale_lint_on_text_changed = 'never'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_fix_on_enter = 0
let g:ale_fix_on_insert_leave = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:netrw_browse_split = 0

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
" inoremap <silent><expr> <TAB>
"     \ coc#pum#visible() ? coc#pum#next(1):
"     \ <SID>check_back_space() ? "\<Tab>" :
"     \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gps :Gpush<CR>
nnoremap <Leader>gpl :Gpull<CR>

Plug 'moll/vim-node'
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
  \ endif

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

call plug#end()

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" STUFF
"syntax on
filetype on
filetype plugin on
filetype indent on
set nocompatible

let base16colorspace=256
colorscheme base16-ashes

" Let's save undo info!
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

set noswapfile

set background=dark
set encoding=utf-8
set number
set relativenumber
set laststatus=2
set scrolloff=3

set wildignore+=*/.git/*,*/.svn/*

" Whitespace
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set wrap
set backspace=indent,eol,start
set autoindent
set smartindent

set colorcolumn=80

set listchars=nbsp:·,tab:▸\ ,eol:¬
set list

set lazyredraw
set ttyfast
set nocursorline
" SEARCH
set hlsearch
set incsearch
set ignorecase
set smartcase

set exrc
set secure

" neovim live substitution
set inccommand=nosplit

" Use OS X clipboard
" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Visual bell
set visualbell
" Paste helper - press F2 and paste block of codes
set pastetoggle=<F2>
" set mouse mode (use to scroll and select)
set mouse=a

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" LEADER
let mapleader = ","
" remap ,W to clean all trailing whitespace in fil
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" ,ft will fold html tag
nnoremap <leader>ft Vatzf
" jk is escape
inoremap jk <esc>
inoremap <c-c> <esc>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" OS X Copy
vnoremap <Leader>cp :!pbcopy<CR>u :echo "copied"<CR>
" ,s to save
nmap <Leader>r <Plug>(Prettier)
nmap <leader>s :w<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>
nnoremap <leader>j :m +1<CR>
nnoremap <leader>k :m -2<CR>

if has("gui_running")
  set guifont=SourceCodePro+Powerline+Awesome+Regular:h14
endif
