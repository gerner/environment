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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" I don't know what modula2 is, but I think *.md is markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown
