" .vimrc for all users

syntax on

set hlsearch
set number

set background=dark

" force 256 colors
"set t_Co=256

if has("gui_running")
	set cursorline
	colorscheme torte
endif

