.PHONY: \
	compile \
	clean \
	all

compile:
	@rebar compile

clean:
	@rebar clean

all: \
	clean \
	compile
