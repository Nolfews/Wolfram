PROJECT_NAME = wolframFolder
BINARY_NAME = wolfram
STACK_CMD = stack

all: build

build:
	$(STACK_CMD) build --stack-yaml $(PROJECT_NAME)/stack.yaml

install: build
	$(eval BIN_PATH := $(shell $(STACK_CMD) path --local-install-root --stack-yaml $(PROJECT_NAME)/stack.yaml))
	cp "$(BIN_PATH)/bin/$(BINARY_NAME)" ./$(BINARY_NAME)

clean:
	$(STACK_CMD) clean --stack-yaml $(PROJECT_NAME)/stack.yaml

test:
	$(STACK_CMD) test --stack-yaml $(PROJECT_NAME)/stack.yaml
