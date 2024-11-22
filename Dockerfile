# Etapa 1: Construção do projeto
FROM node:18 AS build
WORKDIR /app

# Copiar os arquivos do projeto para o contêiner
COPY package*.json ./
COPY . .

# Instalar dependências e construir o projeto
RUN npm install
RUN npm run build

# Etapa 2: Servir os arquivos estáticos
FROM nginx:1.23
WORKDIR /usr/share/nginx/html

# Remover arquivos padrão do Nginx
RUN rm -rf ./*

# Copiar os arquivos de build para o diretório do Nginx
COPY --from=build /app/build .

# Expor a porta padrão do Nginx
EXPOSE 80

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]
