" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins go in here
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sharkdp/fd'
Plug 'tpope/vim-fugitive'

call plug#end()

" nerdtree config
map <C-n> :NERDTreeToggle<CR>

" fzf config
nnoremap <C-p> :Files<CR>
let $FZF_DEFAULT_COMMAND = "fd --type file --hidden --no-ignore --exclude '{.git,node_modules,vendor,build,tmp}'"
