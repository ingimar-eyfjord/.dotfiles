# [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

alias up='cd ..'
alias back='cd -'
# PS1="[\[\e[31;37m\]\\t\[\e[0m\]] \[\e[37m\]\W\[\e[0m\]\n 🖊️  "
# CLICOLOR=1
# LSCOLORS=Gxfxbxdxcxegedabagacad
alias tldr='docker run --rm -it -v ~/.tldr/:/root/.tldr/ nutellinoit/tldr'
sayhello(){
	echo "Hello world function!"
}
#Avctivate python env
# act() { . $(fd activate$ ~py-env | fzf) ; }

quif(){
file=~/quif/templates/html/.html
search="TITLE"
replace="$2"
cat $file | sed -e "s/$search/$replace/" >> $1
}
test(){
file=~/quif/templates/html/index.html
vim $file
}
