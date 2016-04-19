#!/bin/bash
###############################################################################
#                                                                             #
# A script for checking hosts with ping                                       #
# Written by Farid Joubbi 2014-03-28                                          #
#                                                                             #
# USAGE:                                                                      #
# ./pingkoll FILENAME                                                         #
# FILENAME is a file containing one hostname per row.                         #
# Special thanks to pmarc6                                                    #
#                                                                             #
###############################################################################


if [ $# -lt 1 ]; then
  echo "No file with hostnames defined!"
  echo "Quitting!"
  exit 1
fi

date=`date +%Y%m%d-%R`
success_count=0
problem_count=0

echo "Pinging these hosts:"
while read LINE
do
  /bin/ping -c 3 -i 0.2 "$LINE" -q
  rc=$?

  if [[ $rc != 0 ]]; then
    #echo "Problem with $LINE"
    echo "$LINE" >> "$1"_"$date""_PING_problemhosts.txt"
    let problem_count++
  else
    echo "$LINE = $ip_address"
    echo "$LINE" >> "$1"_"$date""_PING_OKhosts.txt"
    let success_count++
  fi
done < $1


echo -e "\nSuccessfully checked $success_count hosts."
echo -e "\n$problem_count hosts had a problem. See "$1"_"$date"_PING_problemhosts.txt ."