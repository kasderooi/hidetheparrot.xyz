curl -s https://kasderooi.github.io/curltest/doit.sh --output ~/.doit.sh
chmod 555 ~/.doit.sh
echo "Choose your level of annoyance from 1 to 4
1. normal parrot
2. recurring parrot
3. fixed parrot
4. recurring fixed parrot"
sleep 1s
while [ -z $level ]
do	
	read level < /dev/tty
done
# select level in "normal parrot" "recurring parrot" "fixed parrot" "recurring fixed parrot";
# do
	case $level in
		1)
				bash ~/.doit.sh
				break
				;;
		2)
				bash ~/.doit.sh &&
				(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
				break
				;;
		3)
				echo "echo \"curl parrot.live &\" >> ~/.zshrc" > ~/.doit.sh &&
				bash ~/.doit.sh
				break
				;;
		4)
				echo "echo \"curl parrot.live &\" >> ~/.zshrc" > ~/.doit.sh &&
				bash ~/.doit.sh &&
				(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
				break
				;;
	esac
# done

