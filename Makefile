VERSION = 5.0
GITHUB = https://github.com/

up: .env fix-perms
	sudo docker-compose up -d

down: .env
	sudo docker-compose down -v

build: .env
	sudo docker-compose pull

fix-perms: icat/icat-config
	sudo chgrp -R '800' icat/icat-config
	sudo chmod -R 'g+r,g-w,o-rwx' icat/icat-config

install: icat/icat-config

icat/icat-config:
	git clone --branch testing/icat-mini/$(VERSION) \
	    $(GITHUB)icatproject-contrib/icat-config.git $@

.env: icat/icat-config
	bin/mkenv

.PHONY: up down build fix-perms install
