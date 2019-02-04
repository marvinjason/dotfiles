" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins go in here
call plug#begin('~/.vim/plugged')

" Plug 'andymass/vim-matchup'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'sharkdp/fd'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

call plug#end()

" vim config
set backspace=indent,eol,start
set clipboard=unnamedplus " need +xterm_clipboard feature enabled in vim
"set clipboard=unnamed " use this for macOS
" set cursorline " Need to use vim 8.1+ because https://github.com/vim/vim/issues/2584
set expandtab
set hidden
set hlsearch
set incsearch
set list
" set listchars=tab:»·
" set listchars+=trail:·
" set listchars+=extends:»
" set listchars+=precedes:«
set noswapfile
set nowrap
set number
set shiftwidth=2
set tabstop=2

set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
" off and the line continues beyond the left of the screen

" vim status line
set laststatus=2

function! FilePath()
  return expand('%') !=# '' ? expand('%') : '[No Name]'
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'paste', 'gitbranch' ],
      \             [ 'readonly', 'filepath', 'modified' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'paste', 'gitbranch' ],
      \             [ 'readonly', 'filepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filepath': 'FilePath'
      \ }
      \ }

" vim window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Hide highlighting of current search results
nnoremap <silent> <CR> :nohlsearch<CR>

" Open current file in default application
nnoremap <C-z> :!xdg-open %

" nerdtree config
map <C-n> :NERDTreeToggle<CR>

" fzf config
nnoremap <C-p> :Files<CR>
let $FZF_DEFAULT_COMMAND = "fd --type file --hidden --no-ignore --exclude '{.git,node_modules,vendor,build,tmp}'"
let $FZF_DEFAULT_OPTS = "--color bg+:-1,hl:107,hl+:114,fg:245,fg+:255"

" silversearcher-ag config
" Override default :Ag to support passing arguments
autocmd! VimEnter * command! -nargs=* -complete=file Ag :call fzf#vim#ag_raw(<q-args> . ' .')
nnoremap <C-f> :Ag<Space>

" set up truecolors
if (has("termguicolors"))
  set termguicolors
endif

syntax on
colorscheme onedark

" vim-matchup config
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1

hi MatchParen ctermfg=11

" Set vim's bg to transparent so that it adapts to
" current terminal's bg color.
" hi normal ctermbg=NONE

" Search through methods in current file using tags
function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
     let maxes[i] = max([get(maxes, i, 0), len(list[i])])
     let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()

nnoremap <C-b> :BTags<CR>
