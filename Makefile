MOCHA = ./node_modules/.bin/mocha \
					--reporter list \
					--compilers coffee:coffee-script \
					--require should

TESTS = spec
DEBUG = debug
WATCH = --watch

test:
	$(MOCHA) $(TESTS)

test-debug:
	$(MOCHA) $(DEBUG) $(TESTS)

test-watch:
	$(MOCHA) $(WATCH) $(TESTS)

.PHONY: test