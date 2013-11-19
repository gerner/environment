execute pathogen#infect()

filetype plugin indent on
set tags=.tags,.tags-source
colorscheme desert
set laststatus=2
highlight LineNr ctermbg=black ctermfg=darkgray
highlight StatusLine ctermbg=darkgray ctermfg=lightgray
highlight StatusLineNC ctermbg=darkgray ctermfg=lightgray
highlight VertSplit ctermbg=darkgray ctermfg=lightgray
highlight IncSearch ctermbg=black ctermfg=darkblue cterm=undercurl,bold
set hlsearch
set number
"set statusline=%n\ %m\ %F%r%h%w\ [FORMAT=%{&ff}]\ %m\ [POS=%l,%v][%p%%]\ [LEN=%L]
set statusline=%n\ %.50f[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set completeopt=menuone,menu,longest,preview
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set nofoldenable

" make various whitespace conditions visible
execute 'set listchars+=tab:\-' . nr2char(187)
execute 'set listchars+=eol:' . nr2char(183)
execute 'set listchars+=trail:+'
set list

" autohighlight words under the cursor after 500ms
au CursorHold,CursorHoldI * exec 'match IncSearch /\V\<'. escape(expand("<cword>"), '\/') .'\>/'
setl updatetime=500

" highlight the 80th column
set colorcolumn=80

