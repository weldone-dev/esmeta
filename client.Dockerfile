FROM alpine/git as intermediate
WORKDIR /app
RUN git clone https://github.com/es-meta/esmeta-debugger-client.git

FROM node:16-alpine
WORKDIR /app
COPY --from=intermediate /app/esmeta-debugger-client /app

RUN npm install
