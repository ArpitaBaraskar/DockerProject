FROM node:18-alpine

WORKDIR /DockerProject
COPY package*.json ./
RUN npm ci --only=production
COPY . .

EXPOSE 3000
CMD ["npm", "start"]
