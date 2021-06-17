FROM ubuntu:20.04

RUN apt-get update && apt-get install -y sudo curl git zip
      
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]