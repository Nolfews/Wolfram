##
## EPITECH PROJECT, 2025
## B-FUN-400-NAN-4-1-wolfram-nolan.papa
## File description:
## Makefile
##

PROJECT_NAME = wolframFolder
BINARY_NAME = wolfram
STACK_CMD = stack

all: build install

build:
	$(STACK_CMD) build

install: build
	$(eval BIN_PATH := $(shell $(STACK_CMD) path --local-install-root))
	cp "$(BIN_PATH)/bin/$(BINARY_NAME)" ./$(BINARY_NAME)

clean:
	$(STACK_CMD) clean

fclean:
	$(STACK_CMD) clean
	rm $(BINARY_NAME)

re:
	make clean
	make all

test:
	$(STACK_CMD) test
