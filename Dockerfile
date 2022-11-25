FROM node as build

WORKDIR /app

#Downloading and unzipping
RUN wget https://github.com/fatihelgormus/mobdev_ca3/archive/main.tar.gz \
   && tar xf main.tar.gz\
   &&rm main.tar.gz

WORKDIR /app/mobdev_ca3-main/


RUN npm install -g ionic

RUN npm install 

RUN npm run build --prod

# Switch to the nginx image
FROM nginx:alpine 

#user static
EXPOSE 80

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/mobdev_ca3-main/www/ /usr/share/nginx/html/
