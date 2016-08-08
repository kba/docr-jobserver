FROM mhart/alpine-node

WORKDIR /app

RUN npm install -g coffee-script

ADD . .

RUN npm install

CMD coffee src/lib/server.coffee

