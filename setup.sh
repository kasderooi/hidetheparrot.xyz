function hideyoparrot {
	ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key </dev/tty 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }
	
	for opt; do printf "\n"; done

	local current=`get_cursor_row`
    local start=$(($current - $#))

	trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        local idx=0
        for opt; do
            cursor_to $(($start + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    cursor_to $current
    printf "\n"
    cursor_blink_on
	printf "\033c"
    return $selected
}

function select_opt {
    hideyoparrot "$@" 1>&2
    local result=$?
    echo $result
    return $result
}

touch ~/.doit.sh
chmod 755 ~/.doit.sh
echo "echo \"curl parrot.live\" >> ~/.zshrc" > ~/.doit.sh
sleep 1s

echo "Choose your level of annoyance:"
options=("normal parrot\n"
	"recurring parrot\n"
	"fixed parrot\n"
	"recurring fixed parrot\n"
	"cancel and exit\n")

case `select_opt "${options[@]}"` in 
	0)
		bash ~/.doit.sh
		curl parrot.live
		break
		;;
	1)
		bash ~/.doit.sh &&
		(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
		curl parrot.live
		break
		;;
	2)
		echo "echo \"curl parrot.live &\" >> ~/.zshrc" > ~/.doit.sh &&
		bash ~/.doit.sh
		curl parrot.live
		break
		;;
	3)
		echo "echo \"curl parrot.live &\" >> ~/.zshrc" > ~/.doit.sh &&
		bash ~/.doit.sh &&
		(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
		curl parrot.live
		break
		;;
	4)
		curl parrot.live
		break
		;;
esac
