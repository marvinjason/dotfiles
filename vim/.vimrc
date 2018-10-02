if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins go in here
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

call plug#end()

" nerdtree config
map <C-n> :NERDTreeToggle<CR>
