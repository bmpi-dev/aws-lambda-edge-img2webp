.PHONY: all image package dist clean-files remove-docker-image

all: image package dist clean-files

image:
	docker build --tag amazonlinux:nodejs .

package: image
	docker run --rm --volume ${PWD}/lambda/origin-response-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install sharp --save; npm install path --save; npm install aws-sdk --save; npm install --only=prod"
	docker run --rm --volume ${PWD}/lambda/viewer-request-function:/build amazonlinux:nodejs /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install useragent --save; npm install path --save; npm install --only=prod"

dist: package
	mkdir -p dist && cd lambda/origin-response-function && zip -FS -q -r ../../dist/origin-response-function.zip * && cd ../..
	mkdir -p dist && cd lambda/viewer-request-function && zip -FS -q -r ../../dist/viewer-request-function.zip * && cd ../..

clean-files:
	rm -r lambda/origin-response-function/node_modules
	rm -r lambda/viewer-request-function/node_modules

remove-docker-image:
	docker rmi --force amazonlinux:nodejs