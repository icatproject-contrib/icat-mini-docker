VERSION = 5.0
GITHUB = https://github.com/
LOCAL_USER = $(shell id -u)

up: .env fix-perms
	sudo docker-compose up -d

down: .env
	sudo docker-compose down -v

build: .env
	sudo docker-compose pull
	sudo docker-compose -f compose.yaml -f client.yaml build --pull

run-client: .env fix-perms
	sudo docker-compose -f compose.yaml -f client.yaml run --rm \
	    client-`sed -n -e 's/SUDS=\(.*\)/\1/ p' .env`

fix-perms: icat/icat-config icat/certs/cert.pem client/tmp
	sudo chgrp -R '800' icat/icat-config
	sudo chmod -R 'g+r,g-w,o-rwx' icat/icat-config
	sudo chown -h '800:800' icat/certs/*.pem
	sudo chown '1000:100' client/icat.cfg client/tmp
	sudo chmod '0600' client/icat.cfg

reset-owner: icat/certs/cert.pem client/tmp
	sudo chown -h $(LOCAL_USER) icat/certs/*.pem
	sudo chown -R $(LOCAL_USER) client/icat.cfg client/tmp

install: icat/icat-config

set-passwds: .env reset-owner
	bin/set-local-passwds

set-version: icat/icat-config
	git -C icat/icat-config checkout testing/icat-mini/$(VERSION)
	bin/mkenv

icat/icat-config:
	git clone --branch testing/icat-mini/$(VERSION) \
	    $(GITHUB)icatproject-contrib/icat-config.git $@

.env: icat/icat-config
	bin/mkenv

icat/certs/cert.pem: .env
	bin/mkcert

client/tmp:
	mkdir -p $@

.PHONY: up down build run-client fix-perms reset-owner install \
	set-passwds set-version
