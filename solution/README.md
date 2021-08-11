##################################################################### Part 1 Solution Commands ########################################################################
Step 1:
docker pull infracloudio/csvserver:latest
docker pull prom/prometheus:v2.22.0

Step 2:
sudo docker run -d --name csvserver infracloudio/csvserver:latest
sudo docker ps -a

Step 3:
sudo docker logs csvserver

Step 4:
cat > gencsv.sh <<EOF
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
>EOF

Step 5:
sh gencsv.sh
sh gencsv.sh 100

Step 6:
sudo docker run -d --name csvserver -v /home/sachsona83/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

Step 7:
[sachsona83@jump-host solution]$ sudo docker exec -it c61 netstat -tlnp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver 


Step 8:
sudo docker rm -f csvserver

Step 9:
sudo docker run -d --name csvserver -e CSVSERVER_BORDER=Orange -p 9300:9300 -v /home/sachsona83/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

###### USEFUL URL TO TEST #######
CSVSEVER - http://35.197.56.241:9300/
PROMETHEUS DASHBOARD - http://35.197.56.241:9090
