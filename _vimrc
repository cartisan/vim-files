set guifont=DejaVu\ Sans\ Mono:h10

" pathogen
call pathogen#infect()                      " load everyhting else
call pathogen#helptags()                    " load plugin help files

" syntastic
"let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_mode_map = { 'mode': 'active'}
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0


" syntax highlighting
syntax on
filetype on                 " enables filetype detection
filetype plugin indent on   " enables filetype specific plugins
au BufNewFile,BufRead *.pro set filetype=prolog   " Prolog syntax for filetype pro


set number

" Highlight search result and incremental search"
set hlsearch
set incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" pep8
let g:pep8_map='<leader>8'

" supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" continously show filename on bottom
set modeline
set ls=2

" copy to clipboard
set clipboard=unnamed

" change leader-key to comma
let mapleader=","

command! W w !sudo tee % > /dev/null

" Rope mapings
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

set backspace=indent,eol,start

" ShowMarks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 


" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Change split navigation to work without Ctrl+W
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Use ALT key to navigate tabs
map <A-h> :tabN<CR>
map <A-l> :tabn<CR>

nnoremap \ :noh<return>

" solarized

if has('gui_running') 
  colorscheme solarized
  set background=light
  let g:solarized_termcolors=256

" remove gvim widgets
  :set guioptions-=m  "remove menu bar
  :set guioptions-=T  "remove toolbar
  :set guioptions-=r  "remove right-hand scroll bar
  :set guioptions-=L  "remove left-hand scroll bar on vertical splits
 
else 
  "no need for details since ConEmu takes care of solarized
endif 

" Use Leader+e to open NerdTree
map <Leader>e :NERDTreeToggle<CR>

" Fancy python-IDE mode (https://dev.launchpad.net/UltimateVimPythonSetup)
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py :source C:\Users\leon\vimfiles\python
endif

autocmd BufRead *.py nmap <F5> :!python %<CR>

" Use incsearch instead of normal search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


""""""""""""""
" LATEX SETUP"
""""""""""""""

" Spell check in latex
augroup latexsettings
    autocmd FileType tex set spell
augroup END

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Compile to pdf instead of dvi
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi, pdf'

"let g:Tex_CompileRule_pdf = 'start latexmk -pdf -pvc $*'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $* | bibtex main1-blx.aux | bibtex main2-blx.aux | bibtex main3-blx.aux | bibtex main4-blx.aux | bibtex main5-blx.aux | bibtex main6-blx.aux |bibtex main7-blx.aux | pdflatex -interaction=nonstopmode $* |pdflatex -interaction=nonstopmode $*'

let g:Tex_ViewRule_pdf = 'C:/users/leon/PDFXCview.exe'
