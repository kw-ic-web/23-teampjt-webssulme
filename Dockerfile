FROM openjdk:11
ARG JAR_FILE=build/libs/*.war
COPY ${JAR_FILE} app.war
ENTRYPOINT ["java","-jar","/app.jar"]
