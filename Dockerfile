

FROM node AS builder

WORKDIR /app

#Downloading and unzipping
RUN wget https://github.com/fatihelgormus/MobDev_CA3/archive/main.tar.gz \
   && tar xf main.tar.gz\
   &&rm main.tar.gz

# Create a non-root user to own the files and run our server
#RUN adduser -D static

WORKDIR /app/MobDev_CA3-main/


RUN npm install -g ionic
RUN npm install 

RUN npm run-script build --prod

# Switch to the nginx image
FROM nginx:alpine 

#user static
EXPOSE 80

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/mobdev_ca3-main/www /usr/share/nginx/html/

# Uploads a blank default httpd.conf
# This is only needed in order to set the `-c` argument in this base file
# and save the developer the need to override the CMD line in case they ever
# want to use a httpd.conf
#COPY httpd.conf .

#copy package*.json /app

#Copy ./ / app/



# Copy the static website
# Use the .dockerignore file to control what ends up inside the image!
# NOTE: Commented out since this will also copy the .config file
# COPY MobDev_CA3 .

# Run busybox httpd
#CMD ["/busybox", "httpd", "-f", "-v", "-p", "8080", "-c", "httpd.conf", "./index.html"]
