#!/bin/bash

## getip.sh - Consulta IP público e envia por email
## Escrito por: Richard Amaral de Jesus
## E-mail: richard.ajesus@gmail.com
## Exemplo de uso: ./getip.sh start
## Agendamento feito no crontab: # crontab -e
## */30 * * * *  /root/scripts/getip.sh start

function start(){
	TITULO_EMAIL="TITULO DO EMAIL"
	EMAIL_DESTINO="email@company.com"
	
	# Consulta o IP público e armazena no arquivo para comparação
	IP=`/usr/bin/wget http://ipinfo.io/ip -qO -`
	LAST_IP=`cat /root/scripts/last_ip.txt`

	if [ "$IP" 	!= "$LAST_IP" ]; then
		echo  $IP > /root/scripts/last_ip.txt
		/usr/bin/mutt -s "$TITULO_EMAIL" $EMAIL_DESTINO < /root/scripts/last_ip.txt
		exit
	fi
	exit
}

case $1 in start) start;;
*) echo "Insira um parametro para /root/scripts/getip.sh start"
exit 0
;;

esac
