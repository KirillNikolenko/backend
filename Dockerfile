FROM node:16

# Create app directory
WORKDIR /app

# Install nodemon
RUN npm install -g nodemon

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm ci \
 && npm cache clean --force \
 && mv /app/node_modules /node_modules

# Bundle app source
COPY . .

EXPOSE 8000
CMD ["node", "build/src/index.js"]