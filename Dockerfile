FROM node:14.21-alpine AS builder
WORKDIR /app
COPY package*.json ./
COPY yarn.lock ./
RUN yarn 
COPY . .
RUN yarn build 

FROM node:14.21-alpine AS production
WORKDIR /app
COPY package*.json ./
COPY yarn.lock ./
RUN yarn --production
COPY --from=builder /app/dist ./dist


CMD ["yarn", "start"]