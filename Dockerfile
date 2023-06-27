FROM node:14

WORKDIR /app/school-management-system

COPY package.json .

RUN yarn install

COPY . .

EXPOSE 9999

CMD [ "yarn", "start" ]