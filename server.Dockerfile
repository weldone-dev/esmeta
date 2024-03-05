FROM alpine/git as intermediate
WORKDIR /app
RUN git clone https://github.com/es-meta/esmeta.git . && git submodule update --init


FROM sbtscala/scala-sbt:eclipse-temurin-focal-17.0.10_7_1.9.9_3.4.0 as builder
WORKDIR /app
COPY --from=intermediate /app/ /app
COPY ./WebServer.scala /app/src/main/scala/esmeta/web/WebServer.scala
#RUN sed -i 's/localhost/0.0.0.0/' src/main/scala/esmeta/web/WebServer.scala

ENV ESMETA_HOME="/app"
ENV PATH="$ESMETA_HOME/bin:$PATH"

RUN /bin/bash -c "sbt assembly"
RUN /bin/bash -c "source .completion"


EXPOSE 8080

