# ============================================================================ #
# ~/.zsh/zshrc
# Questo file viene eseguito solo quando la shell e'
# interattiva, quindi NO script, NO crontab, SI sadomaso.
# ---------------------------------------------------------------------------- #

# OPTIONS
# -------
setopt NO_beep			# Spegne il beep in ZLE
setopt append_history		# Appende al file $HISTORY, invece di sovrascrivere
setopt auto_cd			# Entra nelle directory senza usare 'cd'
setopt auto_pushd		# Ficca $OLDPWD (dir precedente) nello stack delle dir
setopt check_jobs		# Avverte dei processi in background prima di killare la shell
setopt complete_in_word		# Completa nel mezzo delle word (altrimenti parte dalla fine)
setopt correct			# Corregge lo spelling dei comandi
setopt equals			# Permette =command al posto di `which command`
setopt extended_glob		# Usa '~', '^' e '#' per i pattern
setopt extended_history		# Salva i timestamp nella history
setopt NO_flow_control		# Disabilita il flow control (^S e ^Q), MAI usato e BDAC
#setopt glob_complete		# Quando la word da completare contiene un glob pattern,
				# invece di inserire il risultato del glob, cicla tra i
				# risultati, come nella completion con  MENU_COMPLETE
setopt hist_ignore_dups		# se il comando e' uguale al precedente non metterlo nella history
setopt hist_no_store		# non salvare nella history i comandi "history"
setopt NO_hup			# Non manda -HUP ai processi quando la shell muore
setopt list_packed		# Completion list piu' piccola, con colonne di varia larghezza
setopt long_list_jobs		# Elenca i job nel formato esteso
setopt notify			# Avvisa subito dello status dei job in background, invece di
						# aspettare un nuovo prompt
setopt numeric_glob_sort	# Sort numerico per file contenenti numeri (a_00, a_01, ...)
setopt print_exit_value		# Printa l'exit value quando e' diverso da zero
setopt pushd_ignore_dups	# Purga i duplicati dallo stack delle directory
#setopt pushd_silent		# Non printa lo stack delle dir dopo pushd o popd
setopt NO_rm_star_silent	# Chiede conferma per: 'rm *' o 'rm /path/*'
setopt short_loops		# Permette le forme abbreviate di for, if, function, etc...
setopt interactive_comments	# Permette di lasciare commenti sulla cmd line, utile con 'script'


# PROMPT
# ------
autoload -U colors
colors

# Hostname colorati in base al loro hash # idea copiata para para da
# nickcolors.pl per irssi
colnames=(
	black
	red
	green
	yellow
	blue
	magenta
	cyan
	white
	default
)

for color in $colnames; do
	eval f$color='%{${fg[$color]}%}'
	eval b$color='%{${bg[$color]}%}'
done

chash=0
foreach letter ( ${(ws::)HOST[(ws:.:)1]} )
	(( chash += #letter ))
end
crand=$(( $chash % 9 ))
crandname=$colnames[$crand]
eval cprompt='%{${fg[$crandname]}%}'
# PS1="[%T] ${fcyan}%m${fdefault}%(2j.|%j.):%3c%# "
PS1="[%T] ${cprompt}%m${fdefault}%(1j.|%j.):%3c%# "

# Esperimento per opzione "shelltitle" di screen (shelltitle '% |zsh')
#if [[ $TERM == screen* ]]; then
#    PROMPT=$'\ek\e\\[%T] '"${cprompt}%m${fdefault}"'%(1j.|%j.):%3c%# '
#else
#    PROMPT=$'[%T] '"${cprompt}%m${fdefault}"'%(1j.|%j.):%3c%# '
#fi

# utile con screen e un caption che mostri l'hardstatus della window
# usato nelle shell remote e' comodo con la finestra splittata.
function no_precmd {
    case $TERM in
    rxvt*|screen*|*xterm*|(dt|k)term|Eterm)
	print -Pn "\e]2;%n@%m:%~\e\134"
    ;;
    linux)
    ;;
    esac

    # resetta il titolo a "zsh" dopo un comando
    #if [[ $TERM == screen* ]]; then
    #    echo -ne "\ekzsh\e\\"
    #fi
}

# Cambia il titolo della finestra di screen con il nome
# dell'host verso cui si fa ssh.
# $1 e' TUTTA la string del comando, argomenti compresi.
function preexec () {
    local -a cmd
    cmd=(${(z)1})

    if [[ $TERM == screen* ]]; then
	# Se il comando e' "ssh" imposta l'ultimo argomento (l'hostname) come
	# titolo
	if [[ $cmd[1] == ssh && ! -z $cmd[-1] ]]; then
	    echo -ne "\ek${cmd[-1]##*@}\e\\"
	#else
	#    echo -ne "\ek${1%% *}\e\\"
	fi
    fi
}

#function title {
#  if [[ $TERM == "screen" ]]; then
#    # Use these two for GNU Screen:
#    print -nR $'\033k'$1$'\033'\\
#
#    print -nR $'\033]0;'$2$'\a'
#  elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then
#    # Use this one instead for XTerms:
#    print -nR $'\033]0;'$*$'\a'
#  fi
#}

# screen+zsh
# da: http://stackoverflow.com/questions/171563/whats-in-your-zshrc/187877#187877
# function title {
#     if [[ $TERM == "screen"* ]]; then
#         print -nR $'\033k'$1$'\033\\'
#         print -nR $'\033]0;'$2$'\a'
#     fi
# }
# 
# function precmd {
#     title "zsh" "$PWD"
# }   
# 
# function preexec {
#     emulate -L zsh
#     local -a cmd; cmd=(${(z)1})
#     title "$cmd[1]:t" "$cmd[2,-1]"
# }

# ENVIRONMENT
# -----------
# Queste variabili d'ambiente servono solo in modalita' interattiva
# Binda le seguenti variabili d'ambiente ai loro rispettivi array (ex: $perl5lib[@] )
declare -T LD_LIBRARY_PATH ld_library_path
declare -T PERL5LIB perl5lib
declare -T PYTHONPATH pythonpath

# FTP in passive mode (CPAN)
export FTP_PASSIVE=1

# History
HISTSIZE=2000
SAVEHIST=10000
HISTFILE=${HOME}/.history

# Opzioni per less
# -c	: pulisce lo schermo prima di mostrare il file
# -i	: ignore case (ma una ricerca uppercase annulla l'opzione)
# -M	: mostra percentuale del file ed e' piu' verboso di more
# -x<n> : lunghezza del tab
LESS=-ciMx4r
PAGER=less
export LESS PAGER
# man page colorate SENZA usare most! ;-P
# http://nion.modprobe.de/blog/archives/572-less-colors-for-man-pages.html 
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# $EDITOR e $VISUAL
if (( $+commands[vim] )); then
	EDITOR=vim
	VISUAL=vim
else
	EDITOR=vi
	VISUAL=vi
fi
export EDITOR VISUAL

# ssh-askpass, utility grafica
(($+commands[ssh-askpass] )) && export SSH_ASKPASS=ssh-askpass

# Controllo accessi al server
watch=(notme)
LOGCHECK=300		# check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'


# BINDINGS
# --------
[[ -e ${ZDOTDIR}/bind ]] && . ${ZDOTDIR}/bind


# XXX DA SISTEMARE !!!
# COSE che dipendono dal sistema operativo
# ----------------------------------------
[[ -e ${ZDOTDIR}/cose ]] && . ${ZDOTDIR}/cose


# ALIASES
# -------
[[ -e ${ZDOTDIR}/alias ]] && . ${ZDOTDIR}/alias


# COMPLETION
# ----------
zmodload zsh/complist
autoload -U compinit && compinit
[[ -e ${ZDOTDIR}/zcomp ]] && . ${ZDOTDIR}/zcomp


# FUNCTIONS
# ---------
[[ -e ${ZDOTDIR}/zfunc ]] && . ${ZDOTDIR}/zfunc


# BEN-VENUTO
# ----------
# Tutte le cazzate da mostrare quando si lancia una nuova shell, tipo
# fortune, todo, etc...
[[ -e ${ZDOTDIR}/welcome ]] && . ${ZDOTDIR}/welcome


# LOCAL SETTINGS
# --------------
[[ -e ${ZDOTDIR}/local ]] && . ${ZDOTDIR}/local


# AUTOLOAD
# --------
autoload -U zcalc
autoload -U zmv
autoload -U zargs

# Non mi piace, ma lo segno per il futuro.
## # zsh-mime-setup
## autoload -U zsh-mime-setup
## #zstyle :mime: mime-types /etc/mime.types
## zstyle :mime: mailcap ~/.mailcap /etc/mailcap
## zsh-mime-setup


# Se per caso questo file esce con un valore diverso da zero, sara' PANDEMONIO!
return 0
# vim: ft=zsh
