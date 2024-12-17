# Stage 1: Build the frontend (React)
FROM node:16 AS frontend-build

# Set working directory
WORKDIR /app

# Install dependencies for frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install

# Copy the rest of the frontend code
COPY frontend/ ./

# Build the React app
RUN npm run build

# Stage 2: Set up the backend (Node.js + Express)
FROM node:16 AS backend

# Set working directory
WORKDIR /app

# Install backend dependencies
COPY backend/package.json backend/package-lock.json ./
RUN npm install

# Copy backend code
COPY backend/ ./

# Copy the built frontend from the frontend build stage
COPY --from=frontend-build /app/build /app/public

# Expose port 5000 for the backend
EXPOSE 5000

# Start the backend server
CMD ["npm", "start"]
