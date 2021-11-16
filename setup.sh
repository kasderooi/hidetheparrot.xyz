curl -s https://kasderooi.github.io/curltest/doit.sh --output ~/.doit.sh
chmod 555 ~/.doit.sh
echo "Choose your level of annoyance from 1 to 4
1. normal parrot
2. recurring parrot
3. fixed parrot
4. recurring fixed parrot"
level=0
while [ $level -le 0 ]
do	
	read level
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
				echo "echo \"curl parrot.live&\" >> ~/.zshrc" &&
				bash ~/.doit.sh
				break
				;;
		4)
				echo "echo \"curl parrot.live&\" >> ~/.zshrc" &&
				bash ~/.doit.sh &&
				(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
				break
				;;
	esac
# done

