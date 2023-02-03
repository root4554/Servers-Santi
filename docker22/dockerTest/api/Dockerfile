FROM node:latest
# ENV NODE_ENV=production
RUN apt-get update

COPY ["./src/.", "./"]

CMD [ "node", "apiserver.js" ]