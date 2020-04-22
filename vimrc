packadd! dracula
colorscheme dracula
let g:dracula_italic=0

set nocompatible
set nu
set hidden
set cmdheight=2
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set signcolumn=yes

" make backspace work like most other programs
set backspace=2 

set autoread
set autowrite

if has('mouse')
  set mouse=a
endif

set nobackup
set nowb
set noswapfile
set backupdir=~/tmp,/tmp
set backupcopy=yes
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=/tmp

set clipboard=unnamedplus
set undolevels=1000

nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

set encoding=utf-8 nobomb

syntax on
set laststatus=2

set wildmenu

filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" insert mode key map
nmap <S-Enter> <Esc>O
inoremap <S-Enter> <Esc>O

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4

let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.DSStoree', '\~$', '\.swp', '\.git', 'node_modules', 'venv', '-env', '__pycache__']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1

let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_no_startup_for_diff = 1
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_meaningful_tab_namess = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_synchronize_view = 1
let g:nerdtree_tabs_synchronize_focus = 1
let g:nerdtree_tabs_focus_on_files = 0
let g:nerdtree_tabs_startup_cd = 1
let g:nerdtree_tabs_autofind = 0

autocmd BufEnter NERD_tree* :LeadingSpaceDisable
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:indentLine_color_term = 100
let g:indentLine_color_gui = '#ff0000'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1

" Custom status line with Coc.nvim & lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'currentfunction', 'gitbranch', 'filename', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'fileencoding', 'filetype', 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightLineFilename'
      \ },
      \ } 

function! s:save_buffer() abort
  if empty(&buftype) && !empty(bufname(''))
    let l:savemarks = {
          \ "'[": getpos("'["),
          \ "']": getpos("']")
          \ }

    silent! update

    for [l:key, l:value] in items(l:savemarks)
      call setpos(l:key, l:value)
    endfor
  endif
endfunction

let mapleader  = ","
let g:mapleader = ","

imap jj <Esc>
imap kk <Esc>

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

map <leader>r :source ~/.vimrc<CR>

map <leader>f :NERDTreeFind<CR>
nmap <leader>t :NERDTreeToggle<CR>

" Bind <A-n> for mark all
let g:multi_cursor_select_all_key="n"

map <C-f> :GFiles?<CR>
map <C-b> :Buffers<CR>
map <C-h> :History<CR>

" Enable FZF
set rtp+=/usr/local/opt/fzf

" Coc.nvim
" Prettier shortcut
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <silent> <leader>pf :Prettier<CR>

" GoTo code navigation.
nmap <silent> gd :<C-u>call CocActionAsync('jumpDefinition')<CR>
nmap <silent> gy :<C-u>call CocActionAsync('jumpTypeDefinition')<CR>
nmap <silent> gi :<C-u>call CocActionAsync('jumpImplementation')<CR>
nmap <silent> gr :<C-u>call CocActionAsync('jumpReferences')<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show document
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <c-@> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')