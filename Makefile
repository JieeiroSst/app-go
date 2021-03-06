.PHONY: postgres adminer migrate

postgres:
	docker run --rm -ti --network host -e POSTGRES_PASSWORD=1234 postgres 
adminer:
	docker rm --rm -ti --network host adminer
migrate:
	migrate -source file://migration \
			-database postgres://postgres:1234@localhost/postgres?sslmode=disable up