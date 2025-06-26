IMAGE_NAME=felipegangrel/php
APP_VERSION=latest
PHP_VERSION=8.3.6
COMPOSER_VERSION=2.7.2
XDEBUG_VERSION=3.3.2

build:
	docker build \
		--build-arg PHP_VERSION=$(PHP_VERSION) \
		--build-arg COMPOSER_VERSION=$(COMPOSER_VERSION) \
		--build-arg XDEBUG_VERSION=$(XDEBUG_VERSION) \
		--tag $(IMAGE_NAME):$(APP_VERSION) \
		"."

test:
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -v | grep $(PHP_VERSION)
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -v | grep OPcache
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep xdebug
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -r "xdebug_info();" | grep $(XDEBUG_VERSION)
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep pdo_pgsql
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep zip
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) /usr/bin/composer -V | grep $(COMPOSER_VERSION)
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -i | grep "short_open_tag => Off => Off"
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -i | grep "memory_limit => 512M => 512M"
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep soap
	@docker run --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep intl

destroy:
	docker image rm $(IMAGE_NAME):$(APP_VERSION)

push:
	docker push $(IMAGE_NAME):$(APP_VERSION)
