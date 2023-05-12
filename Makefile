VERSION = 5.0
GITHUB = https://github.com/
LOCAL_USER = $(shell id -u)

up: .env fix-perms
	sudo docker-compose up -d

down: .env
	sudo docker-compose down -v

build: .env
	sudo docker-compose pull

fix-perms: icat/icat-config icat/certs/cert.pem
	sudo chgrp -R '800' icat/icat-config
	sudo chmod -R 'g+r,g-w,o-rwx' icat/icat-config
	sudo chown -h '800:800' icat/certs/*.pem

reset-owner: icat/certs/cert.pem
	sudo chown -h $(LOCAL_USER) icat/certs/*.pem

install: icat/icat-config

icat/icat-config:
	git clone --branch testing/icat-mini/$(VERSION) \
	    $(GITHUB)icatproject-contrib/icat-config.git $@

.env: icat/icat-config
	bin/mkenv

icat/certs/cert.pem:
	bin/mkcert

.PHONY: up down build fix-perms reset-owner install
