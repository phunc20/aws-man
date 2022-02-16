syntax on

" Indentation
filetype plugin indent on
set autoindent
autocmd FileType tex,c,cpp,scala,julia setlocal shiftwidth=2 tabstop=2 expandtab
"autocmd FileType py setlocal shiftwidth=4 tabstop=4
autocmd FileType markdown,python,julia map <F4> :set ts=2 sts=2 noet \| retab! \| set ts=4 sts=4 et \| retab<CR>
autocmd FileType markdown,python,julia map <F2> :set ts=4 sts=4 noet \| retab! \| set ts=2 sts=2 et \| retab<CR>

"" neovim's vim-plug plugin: https://stsewd.dev/posts/neovim-plugins/
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'chrisbra/Colorizer'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

set nocompatible    " be iMproved. Obligatory
filetype off        " Obligatory

" The following line is to have the vim editor display
" line numbers.
set number relativenumber

" I do not understand fully the following 2 lines' meaning,
" I just know it is about tab and space.
"set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
"set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4 

" The following line means:
" maps every single tab stroke to 4 spaces.
" When using this line, you can no longer type \t or ^I,
" i.e. tab, using the tab key on your keyboard.
" However, you can disactivate it if you'd like to have
" ^I in your document.
"set tabstop=4 shiftwidth=4 expandtab

" Share system clipboard btw vim and other apps
set clipboard=unnamed


" https://github.com/tpope/vim-markdown
"let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" ================================================================
" thoughtbot's suggestion (max cantor)
" enter the current millenium
"set nocompatible

" enable syntax and plugins (for netrw) 
" and some more colors
syntax enable

"filetype plugin on
" ---------------------------------------

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
"set path+=**

" Display all matching files when we tab complete
"set wildmenu

" NOW WE CAN:
" - Hit tab to find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer
" ---------------------------------------



" ================================================================


" Scala Syntax Highlighting
"au BufRead,BufNewFile *.scala set filetype=scala
"au! Syntax scala source ~/.vim/syntax/scala.vim

" Highlight search results: Yes or No?
set nohlsearch

" Folding -- save view
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

"" The next line makes code comments in vim in a blue color that is more readable
"" (The default blue is less readable)
set background=dark
":color koehler
:color desert



"" Auto kill after some file update
"" sxhkd
"autocmd BufWritePost *sxhkdrc !killall sxhkd; setsid sxhkd &
"autocmd BufWritePost *sxhkdrc !killall sxhkd; setsid -c sxhkd &
autocmd BufWritePost ~/.config/sxhkd/sxhkdrc !killall sxhkd; setsid -w sxhkd &
"" sxiv
autocmd BufWritePost ~/.Xresources !xrdb ~/.Xresources

"" Spell check (English) set to F6
map <F6> :setlocal spell! spelllang=en_us<CR>
"map <F2> :r $HOME/programming/html/templates/pre-only.html<CR>
"autocmd FileType md nnoremap ;r :r ~/programming/html/templates/pre-only.html<C-R><Esc>
nnoremap ;r Gi<Enter><Enter><Enter><Esc>:r ~/programming/html/templates/pre-only.html<CR>
"autocmd FileType md nnoremap ;r Gi<Enter><Enter><Enter><Esc>:r ~/programming/html/templates/pre-only.html
"autocmd FileType md nnoremap ;r :r ~/programming/html/templates/pre-only.html
"" html tags
""autocmd FileType html,md inoremap ;p <p></p><Esc>FpT>i
"autocmd FileType html inoremap ;p <p></p><Esc>FpT>i
"autocmd FileType md inoremap ;p <p></p><Esc>FpT>i
"autocmd FileType md inoremap ;c <pre></pre><Esc>FpT>i
""autocmd FileType html,md inoremap ;em <em></em><Esc>?eT>i
"autocmd FileType html inoremap ;em <em></em><Esc>?eT>i
autocmd FileType html,markdown,python inoremap ;em <em></em><Esc>FeT>i
autocmd FileType html inoremap ;b <b></b><Esc>FbT>i
autocmd FileType markdown,python,julia inoremap ;b ****<Esc>hi
autocmd FileType html inoremap ;c <code></code><Esc>?c<CR>T>i
autocmd FileType markdown,python,julia inoremap ;c ``<Esc>i
autocmd FileType html,markdown,python inoremap ;pre <pre><CR><CR></pre><Esc>ki
autocmd FileType html,markdown inoremap ;t &lt;&gt;<Esc>?g<CR>hi


"" python-specific
autocmd FileType html,markdown,python inoremap ;f "{}".format()<Esc>i
"" surround with **, i.e. bold face for markdown
autocmd FileType markdown,python let b:surround_{char2nr('b')} = "**\r**"

"nnoremap <F3>:set hlsearch!<CR>
"map <F7>:noh<CR>
map <F12> :ColorHighlight<CR>
"" Capitalize the 1st letter of every word in the current line
"map <F10> :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
map <F10> :s/\<./\u&/g<CR>
"" \<    start of a word
"" &     whatever is matched
"" ^     start of a line
"" \u    uppercase

"" Change split behaviour (The default being `left/above`)
set splitright
set splitbelow

"" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set laststatus=2
set statusline=
set statusline+=\ %f

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
