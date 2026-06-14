QT6BIN_PATH ?= /usr/lib/qt6/bin

QSB_FLAGS ?= --qt6

shaders: $(patsubst %,%.qsb,$(wildcard shaders/*.frag))
.PHONY: shaders

all: shaders
.PHONY: all
.DEFAULT_GOAL := all

shaders/%.qsb: shaders/%
	$(QT6BIN_PATH)/qsb $(QSB_FLAGS) $^ -o $@
