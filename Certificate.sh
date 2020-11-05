#!/bin/bash
 
########################################################
#
#       Check certificates inside a java keystore
#
#       Inspired by http://www.davidgouveia.net/2013/07/simple-script-to-check-expiry-dates-on-a-java-keystore-jks-file/
#
########################################################
TIMEOUT="timeout -k 10s 5s "
KEYTOOL="$TIMEOUT keytool"
THRESHOLD_IN_DAYS="30"
KEYSTORE=""
PASSWORD=""
ALIAS=""
 
ARGS=`getopt -o "p:k:t:a" -l "password:,keystore:,threshold:,alias:" -n "$0" -- "$@"`
 
usage() {
    echo "Usage: $0 --keystore <keystore> --alias <alias>] [--password <password>] [--threshold <number of days until expiry>]"
    exit
}
  
start() {
    CURRENT=`date +%s`

    THRESHOLD=$(($CURRENT + ($THRESHOLD_IN_DAYS*24*60*60)))
    if [ $THRESHOLD -le $CURRENT ]; then
        echo "[ERROR] Invalid date."
        exit 1
    fi

    $KEYTOOL -list -v -keystore "$KEYSTORE" $PASSWORD 2>&1 > /dev/null
    if [ $? -gt 0 ]; then echo "Error opening the keystore."; exit 1; fi

    EXPIRACY=`$KEYTOOL -list -v -keystore "$KEYSTORE" $PASSWORD -alias "$ALIAS" | grep Valid | head -1`
    UNTIL=`$KEYTOOL -list -v -keystore "$KEYSTORE" $PASSWORD -alias "$ALIAS" | grep Valid | head -1 | perl -ne 'if(/until: (.*?)\n/) { print "$1\n"; }'`
    UNTIL_SECONDS=`date -d "$UNTIL" +%s`
    REMAINING_DAYS=$(( ($UNTIL_SECONDS -  $(date +%s)) / 60 / 60 / 24 ))
    if [ $THRESHOLD -le $UNTIL_SECONDS ]; then
        echo "[OK] Certificate '$ALIAS' expires in '$UNTIL' ($REMAINING_DAYS day(s) remaining)."
        exit 0
    elif [ $REMAINING_DAYS -le 0 ]; then
        echo "[CRITICAL] Certificate $ALIAS has already expired."
        exit 2
    else
        echo "[WARNING] Certificate '$ALIAS' expires in '$UNTIL' ($REMAINING_DAYS day(s) remaining)."
        exit 1
    fi

}
 
eval set -- "$ARGS"
 
while true
do
    case "$1" in
        -p|--password)
            if [ -n "$2" ]; then PASSWORD=" -storepass $2"; else echo "Invalid password"; exit 1; fi
            shift 2;;
        -k|--keystore)
            if [ ! -f "$2" ]; then echo "Keystore not found: $1"; exit 1; else KEYSTORE=$2; fi
            shift 2;;
        -t|--threshold)
            if [[ $2 =~ ^[0-9]+$ ]]; then THRESHOLD_IN_DAYS=$2; else echo "Invalid threshold"; exit 1; fi
            shift 2;;
        -a|--alias)
            if [ -n "$2" ]; then ALIAS=$2; else echo "Entry type not set."; exit 1; fi
            shift 2;;
        --)
            shift
            break;;
    esac
done
 
if [ -n "$KEYSTORE" ] && [ -n "$ALIAS" ]
then
    start
else
    usage
fi
