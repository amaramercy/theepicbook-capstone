# Stage 1: Build
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy the rest of the app
COPY . .

# Stage 2: Production image
FROM node:20-alpine

WORKDIR /app

# Copy built app and dependencies
COPY --from=build /app /app

# Expose backend port
EXPOSE 3000

# Set NODE_ENV to production
ENV NODE_ENV=production

# Start the backend
CMD ["node", "server.js"]

