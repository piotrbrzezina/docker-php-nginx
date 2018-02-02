# docker-php-nginx


##build
```
docker build -f ./docker/app/Dockerfile -t piotrbrzezina/phpnginx .
docker login
docker push piotrbrzezina/phpnginx
```