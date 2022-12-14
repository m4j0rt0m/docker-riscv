DOCKER_DIR      := base
DOCKER_NAME     := riscv-rtl
DOCKER_VERSION  := v1.0

build:
	docker build -t $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_DIR)

.PHONY: build
