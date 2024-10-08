# java 11 기반
FROM openjdk:17
# WAR_FILE에 파일 경로 설정
ARG WAR_FILE=build/libs/*.war
# 8080포트 노출
EXPOSE 8080
# WAR_FILE 경로의 파일을 컨테이너의 web.war로 이동
COPY ${WAR_FILE} web.war
# 컨테이너에서 war 파일 실행
ENTRYPOINT ["java","-jar","/web.war"]
