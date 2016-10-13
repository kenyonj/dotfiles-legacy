" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set ignorecase    " case insensitive searching
set smartcase     " overrides ignorecase when pattern contains caps
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Hide highlighted terms
map <silent> <leader><cr> :noh<cr>

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Set Gists to secret by default
let g:gist_post_private = 1

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" set cursor shape based on modes
if &term == 'xterm-termite'
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

" indent the whole file
map <Leader>i mmgg=G`m<CR>

" open up our schema
map <Leader>sc :sp db/schema.rb<cr>

" RENAME CURRENT FILE (thanks Gary Bernhardt)
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

" Color scheme
syntax enable
let base16colorspace=256
set background=dark
colorscheme base16-flat

" Toggle relative and non-relative line numbers
function! ToggleNumber()
  if &relativenumber
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction
map <Leader>r :call ToggleNumber()<cr>

" Toggle spell check on/off
function! ToggleSpelling()
  if &spell
    set nospell
  else
    set spell
  endif
endfunction
map <Leader>sp :call ToggleSpelling()<cr>

" Set mail settings
au FileType mail setlocal fo+=aw

" Send specs away
let g:rspec_command = 'call Send_to_Tmux("be rspec {spec}\n")'

" custom surrounds
autocmd FileType erb let b:surround_46 = "<% \r %>"
autocmd FileType erb let b:surround_61 = "<%= \r %>"

" pry
map <Leader>pr Orequire "pry";binding.pry<Esc><CR>

" save and open page
map <Leader>po Osave_and_open_page<Esc><CR>

" escape insert mode quickly
imap jj <Esc>

" Vim and OS share clipboard
set clipboard=unnamed

" Sets airline (status bar) to remove angle brackets and sets a theme
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme="base16"

" Highlight cursor line and cursor column
set cursorline cursorcolumn

" Always have spaces above and below window
set scrolloff=5

" Never wrap
set nowrap

" Common mistypes and what they really should do
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> Wq ((getcmdtype() is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))

" strip all whitespace in current file
map <Leader>ws :StripWhitespace<cr>

" remove all comments
nmap <leader>c :%s/^\s*#.*$//g<CR>:%s/\(\n\)\n\+/\1/g<CR>:nohl<CR>gg

" Rehash with 1.9 style hash syntax
nmap <leader>rh :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>

" ES6 highlighting
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" Elm mappings
let g:elm_format_autosave = 1

" Neomake
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
autocmd! BufWritePost,BufEnter * Neomake

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_elixir_enabled_makers = ['mix']
let g:neomake_elixir_mix_maker = {
  \ 'args': ['compile'],
  \ 'errorformat':
  \ '** %s %f:%l: %m,' .
  \ '%f:%l: warning: %m'
  \ }

let g:neomake_ruby_enabled_makers = ['rubocop']
