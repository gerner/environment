"execute pathogen#infect()

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

" clang-format bindings
map <C-K> :py3f /usr/share/clang/clang-format-6.0/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/clang/clang-format-6.0/clang-format.py<cr>

set exrc
set secure

let g:gtest#highlight_failing_tests = 1

augroup GTest
	autocmd FileType cpp nnoremap <silent> <leader>tt :GTestRun<CR>
	autocmd FileType cpp nnoremap <silent> <leader>tu :GTestRunUnderCursor<CR>
augroup END

autocmd Filetype htmldjango setlocal softtabstop=2 tabstop=2 shiftwidth=2
autocmd Filetype html setlocal softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile *.pxi setlocal filetype=pyrex

" autoindent ino Arduino files
autocmd FileType arduino setlocal smartindent

" indentLine config
let g:indentLine_char = '⋮'

" ignore pycache files in filename completion
set wildignore+=**/__pycache__/**

" add errorformat for pytype
set efm+=File\ \"%f\"\\,\ line\ %l\\,\ %m

set exrc
set secure

" never hide characters (what craziness!!!!!)
set conceallevel=0
let g:indentLine_setConceal=0
let g:vim_json_conceal=0
autocmd FileType markdown setlocal conceallevel=0

" don't add automatic comment continuation
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
syntax on
