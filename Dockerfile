# Stage 1: Build
FROM node:20-slim AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve
FROM node:20-slim
WORKDIR /app
# Копіюємо тільки build та необхідний пакет для роздачі
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./
RUN npm install --only=production && npm install -g serve

EXPOSE 3000
# Використовуємо ваш скрипт з package.json
CMD ["npm", "start"]