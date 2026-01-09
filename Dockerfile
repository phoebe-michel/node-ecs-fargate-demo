# Small production node image
FROM node:18-alpine

# Create app dir
WORKDIR /usr/src/app

# Copy package files first (for caching)
COPY package.json package-lock.json* ./

RUN npm ci --only=production

# Copy app
COPY . .

EXPOSE 3000
CMD ["node", "index.js"]