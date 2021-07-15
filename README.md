# Summary

This is the root repository for OH-Queuing. This project consists of the
`OH-Queuing-Server` repository. See the accompanying repository to get more
detailed information about the server, and development there.

# Developing

This repository consists of a Makefile and a set of `docker-compose` files to help
set everything up. Nginx is used as the reverse proxy. Each environment consists
of a set of Docker containers.

Make sure to clone this repo with `git clone --recurse-submodules`
since the actual server is in the `OH-Queuing-Server`

Before running any of these, cd into `OH-Queuing-Server`, and
run `bundle install` (possibly `bundle install --path vendor`
to keep dependencies local in the directory). 

## Development

Some ports are exposed in the containers to help with connecting to the server/also
debugging.

To build: `make build_dev`  
To run: `make run_dev`  
To bring down: `make down_dev`  
To run the console: `make console_dev`  

The server itself is not in a container (yet). Therefore, to run it, enter:
`make server_dev`

## Testing

To build: `make build_test`  
To run: `make run_test`  
To bring down: `make down_test`  

## Production

All ports are blocked. To configure anything/reset anything, you should directly
run `docker exec` commands/use the Makefile.

There is a public certificate, and encrypted private key to handle SSL. The 
private key has been encrypted with: 

```
openssl enc -in private.key \
    -pbkdf2 \
    -pass stdin > private.key.enc
```

For Nginx, to run correctly, make sure that you have a .env file with the contents:
```
PRIVATE_KEY_PASS="password"
```
Where "password" is for descryption.

To build: `make build_prod`  
To run: `make run_prod`  
To bring down: `make down_prod`  
To run the console: `make console_prod`  
