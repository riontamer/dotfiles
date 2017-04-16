" file: .config/nvim/init.vim | .nvimrc
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'atelierbram/Base2Tone-vim'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/neco-ghc'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kamwitsta/nordisk'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mileszs/ack.vim'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'

call plug#end()

set cmdheight=1
set completeopt=menuone,longest,preview
set expandtab
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set ruler
set shiftwidth=2
set tabstop=2
set termguicolors
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildignorecase
set wildmenu
set wildmode=longest,list,full

" Always call `let` before changing colorscheme.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" colorscheme nord
" colo Base2Tone_EveningDark
colo Base2Tone_PoolDark

let mapleader = ","

autocmd! BufWritePost * Neomake

nnoremap <leader><leader> :noh<CR>

au FileType gitcommit set tw=72

let g:rustfmt_autosave = 1

let g:ackprg = 'ag --nogroup --nocolor --column'

nmap <c-p> :Files<cr>
nmap <leader>s :StripWhitespace<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:ack_autoclose=1

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

let g:netrw_banner = 0

let g:NERDSpaceDelims = 1

set clipboard=unnamedplus
