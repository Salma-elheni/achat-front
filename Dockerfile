# Stage 1: Build the Angular application
FROM node:14 as build

WORKDIR /app

# Install Angular CLI
RUN npm install -g @angular/cli

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Angular application
RUN ng build --prod

# Stage 2: Serve the Angular application
FROM nginx:alpine

# Copy the built Angular files from Stage 1
COPY --from=build /app/dist/crudtuto-Front /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
