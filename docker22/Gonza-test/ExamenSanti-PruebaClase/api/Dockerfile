FROM node:latest
# ENV NODE_ENV=production
RUN apt-get update

COPY ["./src/.", "./"]
RUN npm install
CMD [ "node", "main.js" ]