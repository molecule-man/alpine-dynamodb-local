IMAGE = molecularman/alpine-dynamodb-local
VERSION = 1.0.0

ifdef CIRCLE_BUILD_NUM
	BUILD_NUM = ${CIRCLE_BUILD_NUM}
else
	BUILD_NUM = $(shell git rev-parse --short HEAD)
endif

build:
	docker build -t $(IMAGE):$(VERSION) .
	docker tag $(IMAGE):$(VERSION) $(IMAGE):$(VERSION)-$(BUILD_NUM)

launch: stop
	docker run -d --name adl -p 8000:8000 $(IMAGE):$(VERSION)

test: launch
	sleep 1
	./test.sh

stop:
	docker kill adl && docker rm -f adl || true

push:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-$(BUILD_NUM)
	docker push $(IMAGE):latest
