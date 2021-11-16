curl -s https://kasderooi.github.io/curltest/doit.sh --output ~/.doit.sh
chmod 555 ~/.doit.sh
echo "Choose your level of annoyance from 1 to 4"
select level in "normal parrot" "recurring parrot" "fixed parrot" "recurring fixed parrot"
do
	case $level in
		"normal parrot")
				bash ~/.doit.sh
				break
				;;
		"recurring parrot")
				bash ~/.doit.sh &&
				(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
				break
				;;
		"fixed parrot")
				echo "echo \"curl parrot.live&\" >> ~/.zshrc" &&
				bash ~/.doit.sh
				break
				;;
		"recurring fixed parrot")
				echo "echo \"curl parrot.live&\" >> ~/.zshrc" &&
				bash ~/.doit.sh &&
				(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
				break
				;;
	esac
done

