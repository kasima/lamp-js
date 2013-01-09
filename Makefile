MOCHA = ./node_modules/.bin/mocha \
					--reporter list \
					--compilers coffee:coffee-script \
					--require should

TESTS = controller_spec.coffee
DEBUG = --debug

test:
	$(MOCHA) $(TESTS)

test-debug:
	$(MOCHA) $(TESTS) $(DEBUG)

.PHONY: test