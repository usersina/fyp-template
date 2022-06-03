## ---------------------------------------------------------------------------------------
## This is a helper file with recipies which specifies how to interact with
## the following repository's Dockerfiles as well as the deployment process.
## 
## The recipes described here are used extensively in the pipeline.
## 
## ---------------------------------------- Variables -----------------------------------------
## Overridable variables:
## - IMAGE_NAME: The name of the image to build
## - VERSION: The version of the image
## - HOST_PORT: Host port to expose the container on
IMAGE_NAME ?= ilg-report
VERSION ?= local
HOST_PORT ?= 8080
## 
## Computed variables: (Should not be edited)
## - LOCAL_TAG: The local tag of the locally built image.
## - REMOTE_TAG: The remote tag of the image.
LOCAL_TAG = $(IMAGE_NAME):$(VERSION)
REMOTE_TAG = $(REMOTE_HOST)/$(LOCAL_TAG)
# ----------------------------------------- Imports ------------------------------------------
## ----------------------------------------- Commands -----------------------------------------
help:				## Show this help
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

build:		##
	docker build -t $(IMAGE_NAME):$(VERSION) .

run:
	docker run --name $(IMAGE_NAME) -it --rm -p $(HOST_PORT):3000 $(LOCAL_TAG)

build-and-run:
	@make build && make run

.DEFAULT:
	@echo Unkown command $@, try make help

# ----------------------------------------- Guards --------------------------------------------
