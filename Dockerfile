FROM openjdk:11
ARG WAR_FILE=build/libs/*.war
COPY ${WAR_FILE} web.war
ENTRYPOINT ["java","-jar","/web.war"]
