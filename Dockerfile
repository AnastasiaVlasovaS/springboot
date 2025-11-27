FROM eclipse-temurin:17.0.6_10-jre
VOLUME /tmp
RUN useradd -ms /bin/bash spring-user
USER spring-user

WORKDIR /application

COPY target/*.jar app.jar

RUN java -XX:ArchiveClassesAtExit=app.jsa -Dspring.context.exit=onRefresh -jar app.jar & exit 0

ENV JAVA_CDS_OPTS="-XX:SharedArchiveFile=app.jsa -Xlog:class+load:file=/tmp/classload.log"
ENV JAVA_ERROR_FILE_OPTS="-XX:ErrorFile=/tmp/java_error.log"

ENTRYPOINT java \
    $JAVA_ERROR_FILE_OPTS \
    $JAVA_CDS_OPTS \
    -jar app.jar
