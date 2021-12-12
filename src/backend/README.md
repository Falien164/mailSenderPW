# cloud-services-backend

## Build & run docker image

### Build image:
docker build -d cloud-backend-image

### Run container on port 80
docker run -it -d -p 80:80 --name cloud-backend-container cloud-backend-image

### List all containers
docker ps -a 

### Remove container 
docker rm <container_id> -f

### List all images
docker images

### Remove image
docker rmi cloud-backend-image
