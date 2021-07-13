prod_server_id:=docker ps | grep production_server | sed 's/ .*//'

# PRODUCTION COMMANDS
run_prod:
	docker-compose -p production -f docker-compose.prod.yml up --force-recreate --remove-orphans
stop_prod:
	docker-compose -p production stop
down_prod:
	docker-compose -p production down
build_prod:
	docker-compose -p production -f docker-compose.prod.yml build
console_prod:
	docker exec -it $(shell ${prod_server_id}) bash -c "bundle exec rails c"

# DEVELOPMENT COMMANDS
run_dev:
	docker-compose -p development up --force-recreate --remove-orphans
stop_dev:
	docker-compose -p development stop
down_dev:
	docker-compose -p development down
console_dev:
	cd server; bundle exec rails c

# TEST COMMANDS
run_test:
	docker-compose -p test -f docker-compose.test.yml up --force-recreate --remove-orphans
stop_test:
	docker-compose -p test stop
down_test:
	docker-compose -p test down
