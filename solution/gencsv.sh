#!/bin/env/bash

## if no argument passed it will consider default index as 10 & will write the 10 entries
  if [[ -z $* ]] 
  then 
	for i in $(seq 10); do
		echo "$RANDOM" >> inputFile 
	done

## if argument is passed then it will write the entries same as the argument number
  else
	for i in $(seq $1); do
		echo "$RANDOM" >> inputFile
	done	
  fi

## writing the index with comma separated random number

	echo "$(awk '{printf "%s,\t%s\n",NR,$0}' inputFile)" > inputFile 
## Printing the inputFile output ##
cat inputFile

## deleting the content of file for next fresh run
#> inputFile
