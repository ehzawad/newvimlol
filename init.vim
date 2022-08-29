let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif


if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'tomtom/tcomment_vim'
Plug 'shaunsingh/nord.nvim'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'itchyny/lightline.vim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()
" Required:
filetype plugin indent on

" Terminal window settings
command! Term :botright sp | term
command! Termvsp :vertical sp | term
autocmd TermOpen term://* startinsert
tnoremap <Esc> <C-\><C-n>

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

try
  colorscheme nord
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry

let mapleader = ","

noremap <silent> <Leader>l :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=
