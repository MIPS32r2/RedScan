#!/bin/bash
sleep 2
banner1() {

  echo "=================================================================================================="
  echo "                                Thrawn - version 1.0                                               "
  echo "                                     By MIPS32r2                                                    "
  echo "================================================================================================= "
  echo "                                                                                                  "
  echo "                                                                                                  "
  echo "          .                                                      ."
  echo "         .n                   .                 .                  n."
  echo "   .   .dP                  dP                   9b                 9b.    ."
  echo "  4    qXb         .       dX                     Xb       .        dXp     t"
  echo " dX.    9Xb      .db|     dXXb       .db|        dXXb     dXb.     dXP     .Xb"
  echo " 9XXb._       _.dXXXXb dXXXXXb.___.dXXXXb._     dXXXXXb dXXXXXb._       _.dXXP"
  echo "  9XXXXXXXXXXXXXXXXXXXVXXXXXXXXXXXXXXVVXXXXXXXXXXVXXXXXXXXXXXXXXXVXXXXXXXXXXXP"
  echo "   \`9XXXXXXXXXXXXXXXXXXXXX' \`XXXXX'   \`9XXXXXXXXXX' \`XXXXXXXXXXXXXXXXXXXXXXXP'"
  echo "     \`9XXXXXXXXXXXP' \`9XX'   |!|!|      \`9XXXP' \`9XX' \`9XXXXXXXXXXXP'"
  echo "         ~~~~~~~       9X.   |!|!|        ~~~     9X.       ~~~~~~~"
  echo "                         \`b. |!|!|             .d'"
  echo "                           \`b:!|!|!          .d'"
  echo "                             \`\"\"\"'         ''"
}

banner1

banner2() {
  echo "Selecione uma opção"
  echo ""
  echo "Escolha uma opção:"
  echo "1 - XSS"
  echo "2 - SQL Injection"
  echo "3 - Directory Traversal"
  echo "4 - User-Agent Suspeito"
  echo "5 - Sensive Archives"
  echo "6 - Brute Force"
  echo "7 - IP Suspeito"
  echo "8 - Identificar User-Agent Usado"
  echo "9 - Verificar número de requisições"
  echo "10 - Verificar acesso sensível"
}

banner2

read -p "Digite a opção desejada: " opcao
read -p "Digite o caminho do arquivo de log: " LOG_FILE

if [[ ! -f "$LOG_FILE" ]]; then
  echo "❌ Arquivo não encontrado: $LOG_FILE"
  exit 1
fi

case "$opcao" in
1)
  echo "Verificando XSS..."
  sleep 3
  grep -iE --color "<script|%3Cscript" $LOG_FILE
  ;;
2)
  echo "Verificando SQL Injection..."
  sleep 3
  grep -iE --color "union|select|insert|drop|update|delete|--|;|'|\"|%27|%22|%3B|%23" $LOG_FILE
  ;;
3)
  echo "Verificando varredura de Diretórios..."
  sleep 3
  grep -iE --color "\.\./|%2e%2e%2f|%2e%2e/|\.\.%2f|%2e%2e\\|%5c|%2f" $LOG_FILE
  ;;
4)
  echo "Verificando varredura de Scanners..."
  sleep 3
  grep -iE --color "nikto|nmap|sqlmap|acunetix|curl|masscan|python|w3af|dirbuster|fuzz|hydra|zmap|whatweb|wget|fimap|havij" $LOG_FILE
  ;;
5)
  echo "Verificando arquivos sensíveis.."
  sleep 3
  grep -iE --color "\.env|\.git|\.htaccess|\.DS_Store|\.bak|\.old|\.swp|\.zip|\.tar|\.gz|backup|db\.sqlite|id_rsa" $LOG_FILE
  ;;
6)
  echo "Analisando tentativas de Força Bruta..."
  sleep 3
  grep -iE --color "404" $LOG_FILE | cut -d " " -f 1 | sort | uniq -c | sort -nr | head
  ;;
7)
  echo "Primeiro e último acesso de um IP suspeito"
  read -p "Digite o IP suspeito: " IP
  echo "Primeiro acesso"
  grep "$IP" access.log | head -n1
  echo "Último acesso"
  read $primeiro_acesso
  grep "$IP" access.log | tail -n1
  read $ultimo_acesso
  ;;
8)
  echo "Localizar user-agent utilizado"
  read -p "Digite o IP suspeito: " IP
  grep "$IP" $LOG_FILE | cut -d "" -f 6 | sort | uniq
  ;;
9)
  echo "Listar os IPs e Verificar o número de requisições"
  cat $LOG_FILE | cut -d "" -f 1 | sort | uniq -c
  ;;
10)
  echo "Localizar acesso a um determinado arquivo sensível"
  grep "secreto" $LOG_FILE
  ;;
esac
