" ~/.config/nvim/init.vim with the following content:
" set runtimepath^=/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.scripts/nvim/init.vim

" https://www.reddit.com/r/neovim/comments/4r9kwa/change_vim_and_vi_command_to_nvim/"

" IMPORTANT: Remember to setup pyenv and pip install neovim
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'


" Map the leader key to SPACE
let mapleader="\<SPACE>"
" Some Basics
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.

set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>v <C-W><C-V>
nnoremap <Leader>e <C-W><C-S>

if !&scrolloff
    set scrolloff=3       " Show next 3 lines while scrolling.
endif

if !&sidescrolloff
    set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

set nostartofline       " Do not jump to first character with page commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" Use ; for commands.
nnoremap ; :
" Use Q to execute default register.
nnoremap Q @q

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'

Plug 'haishanh/night-owl.vim'

Plug 'mattn/emmet-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'ervandew/supertab'
Plug 'mhinz/vim-grepper'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
"
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"
" Plug 'jremmen/vim-ripgrep'

" " A dependency of 'ncm2'.
" Plug 'roxma/nvim-yarp'
"
" " v2 of the nvim-completion-manager.
" Plug 'ncm2/ncm2'
"
" " NOTE: you need to install completion sources to get completions. Check
" " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" " Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-path'
"
" Plug 'w0rp/ale'

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

Plug 'Shougo/denite.nvim'
Plug 'Shougo/neco-vim'
Plug 'galooshi/vim-import-js'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ }
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'roxma/nvim-yarp'

" General Syntax stuff
Plug 'sheerun/vim-polyglot'

" Python stuff
Plug 'klen/python-mode', { 'for': 'python' }

" CSS/SCSS stuff
Plug 'othree/csscomplete.vim', { 'for': ['css', 'sass', 'scss'] }


Plug 'janko-m/vim-test'
" Initialize plugin system
call plug#end()

let g:SuperTabDefaultCompletionType = "<c-n>"

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme night-owl

" let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}


" Airline Setup
set laststatus=2
" let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='night_owl'
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#ale#enabled = 1

" FZF setup
nnoremap <C-p> :GFiles<CR>
let g:fzf_colors =
\ { 'fg':   ['fg', 'Normal'],
 \ 'bg':   ['bg', 'Normal'],
 \ 'hl':   ['fg', 'Comment'],
 \ 'fg+':   ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
 \ 'bg+':   ['bg', 'CursorLine', 'CursorColumn'],
 \ 'hl+':   ['fg', 'Statement'],
 \ 'info':  ['fg', 'PreProc'],
 \ 'prompt': ['fg', 'Conditional'],
 \ 'pointer': ['fg', 'Exception'],
 \ 'marker': ['fg', 'Keyword'],
 \ 'spinner': ['fg', 'Label'],
 \ 'header': ['fg', 'Comment'] }

" Language Client Setup
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'typescript': ['javascript-typescript-stdio']
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" " enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Ale setup
let g:ale_linters = {'javascript': ['eslint', 'prettier'], 'html': []}
let g:ale_fixers = {
  \   'javascript': [
  \       'eslint',
  \       'prettier',
  \   ],
  \}
let g:ale_javascript_prettier_options = '--single-quote'
"let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <leader>d <Plug>(ale_fix)
let g:ale_sign_column_always = 1

" vim-test setup
let test#strategy = "neovim"
let test#javascript#jest#executable = 'yarn test'
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>



""  Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> for trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>u <Plug>(coc-references)


" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
nmap <silent> <leader>f <Plug>(coc-format)
vmap <leader>f <Plug>(coc-format-selected)


" python-mode setup
" Just disable everything but the nicer syntax and virtualenv
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_breakpoint = 0
let g:pymode_run = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Enable rainbow parentheses
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" Don't autofold code
let g:pymode_folding = 0

" Completion junk
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures_delay = 999

let g:polyglot_disabled = ['python']
nnoremap <silent> <leader> :WhichKey ' '<CR>

" Prettier setup
" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 80

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 2

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'true'

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'false'

" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'avoid'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'none'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'babylon'

" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'

" always|never|preserve
let g:prettier#config#prose_wrap = 'preserve'


let g:grepper = {}
let g:grepper.quickfix = 0
let g:grepper.dir = 'repo,filecwd'
let g:grepper.tools = ['rg', 'git', 'ag', 'grep']
nnoremap <silent> <C-g> :Grepper -cword -noprompt<cr>


let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" fzf setup
nnoremap <silent> <leader>s :Rg<CR>
nnoremap <silent> <leader>w :Buffers<CR>
" "nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>b :BCommits<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <C-p> :GFiles<CR>
