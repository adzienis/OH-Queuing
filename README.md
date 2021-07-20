# Summary

This is the root repository for OH-Queuing. This project consists of the
`OH-Queuing-Server` repository. See the accompanying repository to get more
detailed information about the server, and development there.

This is a Ruby on Rails powered office hours queue. This is the continuation of a pre-existing
office hours queue for [CMQueue](https://cmqueue.xyz) that was written primarily with Node.js, and React.
The website allows multiple courses to create and manage their office hours queues. The main motivation of this
project is to allow better insight and transparency with the analysis of office
hours. To that end, the "queue" is built with many features in order to better
track and augment office hours.

# Features

1. A traditional office hours queue, where students can ask questions, and TA's
   can answer them.

2. Tracking entire life cycle of question (when it was created, when/why was it
   frozen, split/categorize questions based on content).

3. Summarize data from across entire semesters/multiple courses.

4. REST based API to allow course authorized applications to access data to enable
   further, independent features.

5. Course management of semesters, roles, rosters, tags, and questions.

6. Importing and exporting data from CSV files.

7. Ability for students, and TA's to review their own questions/interactions from
   across courses/semesters.

## Motivation

The goal is to have a website, that doesn't necessarily do everything, but has
enough features for us to pull out information to summarize office hours
performance (and hopefully try to make 90 student long office hours not so
unbearable for everyone). The website has some basic course management, with an
emphasis on being able to export the data through the REST API or manually, to
perform more analytics somewhere else.

Currently, very general insight on course performance comes from an integration
with Metabase, which gives a pretty good "no-code" solution to interpreting the
data, but it is still general, and its probably better to get more specific
information.

### Future Features

* While the REST API exists with a large number of endpoints, it would be interesting to have it
  entirely fleshed out so that it is possible to get a large amount of functionality through
  separate applications (maybe overzealous, but to enable the development of an app).


* Flesh out both course and user settings.


* Currently, to manage multiple courses, they are all separated out by explicit endpoints (must go
  to `...courses/1/questions` to get questions for a particular course, even if you manage multiple
  courses). Possibly may look into `hotwire` to get this working, but it would be interesting to see
  if it can be done with just passing an array of course id's into the url (so it would be
  `...courses/questions?course_ids=[1,2]`)
  
* Flesh out analytics: the data is there, and there are sections in the code for embedding
  external graphs. But not sure whether it would be better to spend effort on statistics on
  the site, vs investing time into a proper analytics tool (PowerBI/Excel sheets?).
  
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

Tests are in minitest, and should be more fleshed out. 

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
