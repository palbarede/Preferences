source $HOME/.vimrc

let os	= system('uname -s | tr -d "\n"')

if os == "Darwin"
	colo macvim
else
	colo vividchalk
endif

set mousehide		" Hide the mouse when typing text
