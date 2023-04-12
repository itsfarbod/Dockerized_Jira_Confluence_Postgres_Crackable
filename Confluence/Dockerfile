FROM debian:11
ARG FILENAME
RUN apt update && apt upgrade -y
WORKDIR /
COPY ./$FILENAME /
COPY ./answers.txt /
RUN chmod a+x $FILENAME
RUN ./$FILENAME < answers.txt
COPY ./atlassian-agent.jar /opt/atlassian/confluence/atlassian-agent.jar
COPY ./setenv.sh /opt/atlassian/confluence/bin/setenv.sh
COPY ./server.xml /opt/atlassian/confluence/conf/server.xml
USER confluence
CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
