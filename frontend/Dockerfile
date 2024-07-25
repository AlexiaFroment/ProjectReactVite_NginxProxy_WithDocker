# Utiliser une image Node.js pour le build
FROM node:18 as build



WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build



EXPOSE 5173


CMD ["npm", "run", "dev"]