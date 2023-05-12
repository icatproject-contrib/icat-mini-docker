VERSION = 5.0
GITHUB = https://github.com/

up: fix-perms
	sudo docker-compose up -d

down:
	sudo docker-compose down -v

build:
	sudo docker-compose pull

fix-perms: icat/icat-config
	sudo chgrp -R '800' icat/icat-config
	sudo chmod -R 'g+r,g-w,o-rwx' icat/icat-config

install: icat/icat-config

icat/icat-config:
	git clone --branch testing/icat-mini/$(VERSION) \
	    $(GITHUB)icatproject-contrib/icat-config.git $@

.PHONY: up down build fix-perms install
