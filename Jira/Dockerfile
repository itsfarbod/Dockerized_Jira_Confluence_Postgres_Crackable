FROM debian:11
ARG FILENAME
RUN apt update && apt upgrade -y
WORKDIR /
COPY ./$FILENAME /
COPY ./answers.txt /
RUN chmod a+x $FILENAME
RUN ./$FILENAME < answers.txt
COPY ./atlassian-agent.jar /opt/atlassian/jira/atlassian-agent.jar
COPY ./setenv.sh /opt/atlassian/jira/bin/setenv.sh
COPY ./server.xml /opt/atlassian/jira/conf/server.xml
USER jira
CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
